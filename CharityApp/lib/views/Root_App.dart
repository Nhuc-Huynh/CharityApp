import 'package:charityapp/Config/fontconfig.dart';
import 'package:charityapp/core/model/app_tab.dart';
import 'package:charityapp/core/model/routes.dart';
import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/Component/tab_selector.dart';
import 'package:charityapp/views/Login/login_view.dart';
import 'package:charityapp/views/Pages/friend_page/friend_page.dart';
import 'package:charityapp/views/bloc/searchevent_bloc/bloc/searchevent_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_it/get_it.dart'; 

import 'Pages/calendar_page/calendar_page.dart';
import 'Pages/home_page/home_page.dart';
import 'Pages/home_page/search_view.dart';
import 'Pages/profile_page/profile_page.dart';
import 'bloc/signin_bloc/signin_bloc.dart';
import 'bloc/tab_bloc/tab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef onAddPostCallback = Function(Post post);

class RootApp extends StatelessWidget {
  var context;
  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    this.context = context;
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activateTab) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(85.h),
              child: getappbar(activateTab)),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: getbody(context, activateTab),
          ),
          bottomNavigationBar: TabSelector(
            activeTab: activateTab,
            onTabSelected: (tab) {
              if (tab == AppTab.addObject) {
              } else {
                BlocProvider.of<TabBloc>(context)
                    .add(UpdateTab(newActiveTab: tab));
              }
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: !keyboardIsOpen
              ? FloatingActionButton(
                  heroTag: 'addObjectButton',
                  child: SpeedDial(
                    backgroundColor: Colors.black,
                    animatedIcon: AnimatedIcons.add_event,
                    animatedIconTheme: IconThemeData(size: 25.h),
                    closeManually: false,
                    shape: CircleBorder(),
                    children: [
                      SpeedDialChild(
                        child:
                            Icon(Icons.post_add_rounded, color: Colors.white),
                        backgroundColor: maincolor,
                        label: "B??i ????ng",
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.addPost),
                      ),
                      SpeedDialChild(
                        child: Icon(Icons.event_available_outlined,
                            color: Colors.white),
                        backgroundColor: Colors.red[400],
                        label: "S??? ki???n",
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.addEvent),
                      ),
                    ],
                  ),
                  onPressed: null,
                )
              : null,
        );
      },
    );
  }

  Widget getappbar(AppTab activateTab) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        getNormalAppbar(activateTab),
        // if (activateTab == AppTab.home)
        //   getHomeAppBar()
        // else if (activateTab == AppTab.calendar)
        //   getCalendarAppbar()
        // else if (activateTab == AppTab.friend)
        //   getFriendAppbar()
        // else if (activateTab == AppTab.profile)
        //   getProfileAppbar()
        // else
        //   Text("Fail tab"),
      ],
    );
  }

  AppBar getNormalAppbar(AppTab activateTab) {
    final String nameTab;
    switch (activateTab) {
      case AppTab.home:
        //If home tab, have 2 actions
        return getHomeAppBar();
      case AppTab.friend:
        nameTab = "B???n b??";
        break;
      case AppTab.calendar:
        nameTab = "S??? ki???n";
        break;
      case AppTab.profile:
        nameTab = "H??? s?? c???a b???n";
        break;
      default:
        nameTab = "fail name";
    }
    ;

    return AppBar(
      centerTitle: true,
      backgroundColor: backgroundBottomTab,
      title: Text(nameTab, style: kText24BoldBlack),
    );
  }

  AppBar createPostAppbar({Function? onClickSubmit, Function? onClickBack}) {
    return AppBar(
      centerTitle: true,
      backgroundColor: backgroundBottomTab,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: onClickBack?.call(),
      ),
      title: Text(
        "T???o s??? ki???n",
        style: kText24BoldBlack,
      ),
      actions: [
        TextButton(
          onPressed: onClickSubmit?.call(),
          child: Text(
            "????ng",
            style: kText24BoldBlack,
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ),
      ],
    );
  }

  AppBar getHomeAppBar({Function? onClickNotification}) {
    void onClickSearchEvent() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BlocProvider(
                    create: (context) => SearcheventBloc(),
                    child: SearchEvent(),
                  )));
      return;
    }

    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: 100,
      backgroundColor: backgroundBottomTab,
      titleSpacing: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Text(
          'Meer',
          style: TextStyle(
              color: maincolor,
              fontFamily: 'Redressed_Regular',
              fontSize: 35.sp,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none),
        ),
      ),
      actions: [
        IconButton(
          onPressed: onClickSearchEvent,
          icon: const Icon(Icons.search, color: textColor),
          tooltip: "T??m ki???m",
        ),
        IconButton(
          onPressed: onClickNotification?.call(),
          icon: const Icon(
            Icons.notifications_active,
            color: textColor,
          ),
          tooltip: "Xem th??ng b??o",
        ),
        PopupMenuButton(
          icon: Icon(
            Icons.more_vert,
            color: Colors.black,
          ),
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            PopupMenuItem(
              child: InkWell(
                onTap: () async {
                  String id = "";
                  await FirebaseFirestore.instance
                      .collection("activeusers")
                      .where("id",
                          isEqualTo: (GetIt.instance
                              .get<Authenticator>()
                              .userProfile
                              .id))
                      .get()
                      .then((value) => id = value.docs[0].id);
                  await FirebaseFirestore.instance
                      .collection("activeusers")
                      .doc(id)
                      .delete();
                  // final ggUser = await GoogleSignIn().signIn();
                  // if (ggUser != null) {
                  //   await GoogleSignIn().disconnect();
                  // }
                  await FirebaseAuth.instance.signOut();

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (_) => SigninBloc(),
                          child: Login(),
                        ),
                      ),
                      (route) => false);
                },
                child: ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    color: redcolor,
                  ),
                  title: Text('????ng xu???t'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getbody(BuildContext context, AppTab activateTab) {
    if (activateTab == AppTab.home) {
      return HomePage()..loadPage(context);
    } else if (activateTab == AppTab.calendar)
      return CalendarPage();
    // else if (activateTab == AppTab.addpost)
    //   return AddEventPage();
    else if (activateTab == AppTab.friend)
      return FriendPage();
    else if (activateTab == AppTab.profile) {
      final creator = Authenticator.profile;
      return ProfilePage(creator: creator);
    } else {
      return Text("Fail tab");
    }
  }
}
