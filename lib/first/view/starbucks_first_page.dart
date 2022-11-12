import 'package:flutter/material.dart';
import 'package:starbucks/common/data/colors.dart';

/// 첫 번째 페이지
class StarbucksFirstPage extends StatelessWidget {
  /// 배경 이미지 URL
  final String backImg =
      "https://i.ibb.co/2Pz33q7/2021-12-16-12-21-42-cleanup.png";

  /// Frequency 이미지 URL
  final String frequencyImg = "https://i.ibb.co/QcVn97y/2021-12-16-1-33-11.png";

  /// 추천 메뉴
  final List<Map<String, String>> recommendMenu = const [
    {
      "name": "돌체쿠키라떼",
      "imgUrl": "https://i.ibb.co/SwGPpzR/9200000003687-20211118142543832.jpg",
    },
    {
      "name": "아이스 홀리데이 돌체 쿠키 라떼",
      "imgUrl": "https://i.ibb.co/JHVXZ72/9200000003690-20211118142702357.jpg",
    },
    {
      "name": "스노우 민트 초콜릿",
      "imgUrl": "https://i.ibb.co/M91G17c/9200000003693-20211118142933650.jpg",
    },
    {
      "name": "아이스 스노우 민트 초콜릿",
      "imgUrl": "https://i.ibb.co/jyZK4C9/9200000003696-20211118143125337.jpg",
    },
    {
      "name": "스노우 민트 초콜릿 블렌디드",
      "imgUrl": "https://i.ibb.co/DKkV0rw/9200000003699-20211118143249044.jpg",
    },
  ];

  /// 크리스마스 이벤트 이미지 URL
  final String eventImg = "https://i.ibb.co/Fb0q43T/IMG-F9-BA5-CBCB476-1.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          _StarbucksAppBar(backImg: backImg),

          /// Tip : CustomScrollView 안에서는 모든 첫 번째 위젯이 Sliver로 구현 되어야합니다.
          /// SliverToBoxAdapter는 Container 같은 위젯이라고 보시면 됩니다.

          _StarbucksBody(
              frequencyImg: frequencyImg,
              recommendMenu: recommendMenu,
              eventImg: eventImg),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          print("Deliverys");
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: starbucksPrimaryColor,
            borderRadius: BorderRadius.circular(64),
          ),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Row(
              children: const [
                Text(
                  "Deliverys",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.pedal_bike_outlined,
                  color: Colors.white,
                  size: 28,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StarbucksBody extends StatelessWidget {
  const _StarbucksBody({
    Key? key,
    required this.frequencyImg,
    required this.recommendMenu,
    required this.eventImg,
  }) : super(key: key);

  final String frequencyImg;
  final List<Map<String, String>> recommendMenu;
  final String eventImg;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Frequency
          _frequency(),
          const SizedBox(height: 32),

          /// 추천 메뉴 Title
          _recommendedMenuTitle(),

          const SizedBox(height: 32),

          /// 추천 메뉴 horizontal list view
          _recommendedMenuList(),

          /// Event
          _event(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Padding _event() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 18,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          eventImg,
        ),
      ),
    );
  }

  SizedBox _recommendedMenuList() {
    return SizedBox(
      height: 150, // 높이를 가져야 ListView를 Column 안에 넣을 수 있습니다.
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // 횡스크롤
        itemCount: 100,
        itemBuilder: (context, index) {
          final menu = recommendMenu[index % recommendMenu.length];
          final name = menu["name"] ?? "이름";
          final imgUrl = menu["imgUrl"] ?? "";
          return SizedBox(
            width: 128,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 52,
                  // Tip : circleAvatar 배경에 맞춰서 동그랗게 이미지 넣는 방법
                  backgroundImage: NetworkImage(imgUrl),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(height: 6),
                Text(
                  name,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Padding _recommendedMenuTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          // 공통 스타일
          style: TextStyle(
            fontSize: 28,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: "이찬호",
              style: TextStyle(
                color: starbucksAccentColor,
              ),
            ),
            TextSpan(text: "님을 위한 추천 메뉴"),
          ],
        ),
      ),
    );
  }

  Padding _frequency() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 18,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          frequencyImg,
        ),
      ),
    );
  }
}

class _StarbucksAppBar extends StatelessWidget {
  const _StarbucksAppBar({
    Key? key,
    required this.backImg,
  }) : super(key: key);

  final String backImg;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false, // leading 뒤로가기 버튼 숨기기
      pinned: true, // 스크롤시 bottom 영역을 화면 상단에 남길지 여부
      snap: false, // 중간에 멈출 때 자동으로 AppBar를 펼쳐서 배경을 모두 보여줄지
      floating: true, // AppBar를 화면에 띄울지, 아니면 컬럼처럼 최 상단에 놓을지
      expandedHeight: 252, // 최대 확장되었을 떄 높이
      backgroundColor: Colors.white,

      /// 스크롤시 사라지는 영역
      flexibleSpace: _flexibleSpaceBar(),

      /// 스크롤시 남아있는 영역
      /// SliverAppBar의 bottom은 PreferredSize 위젯으로 시작해야만 합니다.
      bottom: _bottom(),
    );
  }

  PreferredSize _bottom() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(52), // 영역 높이
      child: Container(
        height: 52,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 12,
          ),
          child: Row(
            children: [
              /// What's New
              GestureDetector(
                  onTap: () {
                    print("what's new");
                  },
                  child: _bottomButton(
                    Icons.mail_outline,
                    "What's New",
                  )),
              const SizedBox(width: 32),

              /// Coupon
              GestureDetector(
                onTap: () {
                  print("Coupon 클릭");
                },
                child: _bottomButton(
                  Icons.confirmation_num_outlined,
                  "Coupon",
                ),
              ),
              const Spacer(),

              /// Alarm
              Stack(
                children: [
                  const Icon(
                    Icons.notifications_outlined,
                    color: Colors.grey,
                    size: 32,
                  ),
                  Positioned(
                    right: 2,
                    top: 2,
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: starbucksPrimaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _bottomButton(
    IconData iconData,
    String text,
  ) {
    return Row(
      children: [
        Icon(
          iconData,
          color: Colors.grey,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  FlexibleSpaceBar _flexibleSpaceBar() {
    return FlexibleSpaceBar(
      collapseMode: CollapseMode.pin,
      background: Stack(
        children: [
          /// 백그라운드 이미지
          Positioned.fill(
            bottom: 60,
            child: Image.network(
              backImg,
              fit: BoxFit.fill,
            ),
          ),

          /// 배경 위 위젯
          Positioned(
            left: 24,
            right: 24,
            bottom: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "한 해의 마무리,\n수고 많았어요💖",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "11 ★ until next Reward",
                            style: TextStyle(
                              color: starbucksAccentColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.grey.withOpacity(0.2),
                              value: 0.083,
                              minHeight: 10,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                starbucksAccentColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 28,
                          color: Colors.black,
                        ),
                        children: [
                          const TextSpan(
                            text: "1",
                            style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(
                            text: " / ",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          TextSpan(
                            text: "12 ★",
                            style: TextStyle(
                              color: starbucksAccentColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
