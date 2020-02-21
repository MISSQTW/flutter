enum LayoutType { home, order, mine }

String layoutName(LayoutType layoutType) {
  switch (layoutType) {
    case LayoutType.home:
      return '首页';
    case LayoutType.order:
      return '订单';
    case LayoutType.mine:         
      return '我的';
    default:
  return '';
  }
}
