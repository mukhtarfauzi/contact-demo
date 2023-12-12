import 'package:contact_demo/data/models/user_model.dart';
import 'package:contact_demo/providers/manage_contact.dart';
import 'package:contact_demo/view/theme/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class CloudTab extends StatefulWidget {
  CloudTab({super.key});

  @override
  State<CloudTab> createState() => _CloudTabState();
}

class _CloudTabState extends State<CloudTab> {
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
    final List<User> contacts = provider.contacts.contacts ?? [];
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
            trailing: IconButton(
              onPressed: () => provider.saveContact(contact),
              icon: Icon(
                Icons.save,
                color: provider.isContactSaved(contact.id)
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).unselectedWidgetColor,
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
