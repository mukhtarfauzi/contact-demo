import 'package:contact_demo/data/models/user_model.dart';
import 'package:contact_demo/providers/manage_contact.dart';
import 'package:contact_demo/view/theme/snackbar.dart';
import 'package:contact_demo/view/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class BookmarkTab extends StatefulWidget {
  BookmarkTab({super.key});

  @override
  State<BookmarkTab> createState() => _BookmarkTabState();
}

class _BookmarkTabState extends State<BookmarkTab> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _onRefresh(context);
    });
    super.initState();
  }

  void _onRefresh(BuildContext context) async {
    await Provider.of<ManageContactProvider>(context, listen: false).getContact(
      onSuccess: (_) => _refreshController.refreshCompleted(),
      onFailure: (message) {
        _refreshController.refreshFailed();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBarExtend.error(
            context,
            content: Text(
              message,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ManageContactProvider>(context);
    final List<User> contacts = provider.savedContact.contacts ?? [];
    return SmartRefresher(
      enablePullUp: true,
      header: const WaterDropHeader(),
      controller: _refreshController,
      onRefresh: () => _onRefresh(context),
      child: ListView.builder(
        itemBuilder: (context, index) {
          User contact = contacts[index];
          return ListTile(
            leading: CircleAvatar(
              child: Image.network(contact.avatar ?? ""),
            ),
            title: Text(contact.name ?? "-"),
            subtitle: Text(contact.email ?? "-"),
            trailing: SizedBox(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            padding: const EdgeInsets.all(spacing4x),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text('#ID ${contact.id}', style: Theme.of(context).textTheme.titleMedium,),
                                const Divider(),
                                Row(
                                  children: [
                                    Expanded(child: Text('Name')),
                                    const Text(": "),
                                    Expanded(flex: 2, child: Text('${contact.name}')),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(child: Text('Email')),
                                    const Text(": "),
                                    Expanded(flex: 2, child: Text('${contact.email}')),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(child: Text('Phone')),
                                    const Text(": "),
                                    Expanded(flex: 2, child: Text('${contact.phone}')),
                                  ],
                                ),
                                const Divider(),
                                Text("Address", style: Theme.of(context).textTheme.titleSmall),
                                Divider(),
                                Row(
                                  children: [
                                    Expanded(child: Text('Street')),
                                    const Text(": "),
                                    Expanded(flex: 2, child: Text('${contact.address?.street}')),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(child: Text('City')),
                                    const Text(": "),
                                    Expanded(flex: 2, child: Text('${contact.address?.city}')),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(child: Text('State')),
                                    const Text(": "),
                                    Expanded(flex: 2, child: Text('${contact.address?.state}')),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(child: Text('Zip Code')),
                                    const Text(": "),
                                    Expanded(flex: 2, child: Text('${contact.address?.zip}')),
                                  ],
                                ),
                                const Divider(),
                                ElevatedButton(
                                  child: Text('Print', style: Theme.of(context).textTheme.titleMedium),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          );
                        },
                    ),
                    icon: Icon(
                      Icons.print,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  IconButton(
                    onPressed: () => showAdaptiveDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog.adaptive(
                            title: Text(contact.name ?? "-"),
                            content: const Text(
                                'Are you sure want to remove this contact'),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('No')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    provider.deleteContact(contact.id!);
                                  },
                                  child: const Text('Yes')),
                            ],
                          );
                        }),
                    icon: Icon(
                      Icons.save,
                      color: provider.isContactSaved(contact.id)
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).unselectedWidgetColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemExtent: 100.0,
        itemCount: contacts.length,
      ),
    );
  }
}
