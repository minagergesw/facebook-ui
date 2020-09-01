import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/data/data.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';

class Stories extends StatelessWidget {
  final User currentUser;
  final List<Story> stories;

  const Stories({
    Key key,
    @required this.currentUser,
    @required this.stories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Responsive.isDesktop(context) ? Colors.transparent : Colors.white,
      height: 200.0,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 10.0,
        ),
        itemCount: 1 + stories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4.0,
              ),
              child: _StoryCard(isAddStory: true, currentUser: currentUser),
            );
          }
          final Story story = stories[index - 1];
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4.0,
            ),
            child: _StoryCard(story: story),
          );
        },
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final bool isAddStory;
  final User currentUser;
  final Story story;

  const _StoryCard({
    Key key,
    this.isAddStory = false,
    this.currentUser,
    this.story,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: CachedNetworkImage(
            imageUrl: isAddStory ? currentUser.imageUrl : story.imageUrl,
            height: double.infinity,
            width: 110.0,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: double.infinity,
          width: 110.0,
          decoration: BoxDecoration(
              gradient: Palette.storyGradient,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: Responsive.isDesktop(context)
                  ? const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 4.0,
                      )
                    ]
                  : null),
        ),
        Positioned(
          left: 8.0,
          top: 8.0,
          child: isAddStory
              ? Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {},
                    padding: const EdgeInsets.all(0),
                    color: Palette.facebookBlue,
                    iconSize: 30.0,
                  ),
                )
              : ProfileAvatar(
                  imageUrl: story.user.imageUrl,
                  hasBorder: !story.isViewed,
                ),
        ),
        Positioned(
          bottom: 8.0,
          left: 8.0,
          right: 8.0,
          child: Text(
            isAddStory ? 'Add to story' : story.user.name,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
