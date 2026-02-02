part of "imports.dart";

bool onScroll(
    {required ScrollNotification notification,
    required LoadMoreBloc loadMoreBloc,
    required ScrollController scrollController,
    required Function onLoad,
    required MetaModel metaModel,
    bool isReveres = false}) {
  try {
    logger(
        "isReveres $isReveres ${scrollController.position.userScrollDirection}");

    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      return false;
    }
    if ((metaModel.page - 1) * metaModel.pageSize <= metaModel.xTotalCount) {
      return false;
    }
    if (isReveres == false) {
      if (notification is ScrollUpdateNotification &&
          scrollController.position.userScrollDirection ==
              ScrollDirection.reverse) {
        final double diff =
            scrollController.position.maxScrollExtent - scrollController.offset;

        if (diff <= 50) {
          logger(
              "diff $diff ${loadMoreBloc.state.pagination} ${loadMoreBloc.state.pagination.isNotMatch} ${!loadMoreBloc.state.pagination.isLoading}");
          if ((loadMoreBloc.state.pagination.isNotMatch &&
                  !loadMoreBloc.state.pagination.isLoading) ||
              loadMoreBloc.state.pagination.isError) {
            onLoad();
          }
        }
      }
    } else {
      logger(
          "notification is ScrollUpdateNotification ${notification is ScrollUpdateNotification} ${scrollController.position.userScrollDirection == ScrollDirection.forward}");
      if (notification is ScrollUpdateNotification &&
          scrollController.position.userScrollDirection ==
              ScrollDirection.forward) {
        final double diff = 400 - scrollController.offset;
        logger("diff $diff");

        if (diff <= 10) {
          logger(
              "diff $diff ${loadMoreBloc.state.pagination} ${loadMoreBloc.state.pagination.isNotMatch} ${!loadMoreBloc.state.pagination.isLoading}");
          if ((loadMoreBloc.state.pagination.isNotMatch &&
                  !loadMoreBloc.state.pagination.isLoading) ||
              loadMoreBloc.state.pagination.isError) {
            onLoad();
          }
        }
      }
    }
    return true;
  } catch (e) {
    logger("error in onScroll $e");
    return false;
  }
}
