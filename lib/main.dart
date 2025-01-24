import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:material_table_view/material_table_view.dart';
import 'package:material_table_view/sliver_table_view.dart';
import 'package:material_table_view/table_view_typedefs.dart';
import 'package:sliver_example/table_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MyHomePage(
          title: '',
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Slivers Example'),
            collapsedHeight: 100,
            expandedHeight: 200,
          ),
          SliverLayoutBuilder(
            builder: (BuildContext context, SliverConstraints constraints) {
              final maxExtent = min(constraints.crossAxisExtent, 1200.0);
              return SliverCrossAxisGroup(
                slivers: [
                  SliverCrossAxisExpanded(flex: 1, sliver: SliverGap(0)),
                  SliverConstrainedCrossAxis(
                    maxExtent: maxExtent,
                    sliver: SliverMainAxisGroup(
                      slivers: [
                        SliverBar(
                          maxExtent: 72,
                          minExtent: 48,
                          child: Container(
                            color: theme.colorScheme.surface,
                            padding: EdgeInsets.all(12),
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              child: Text('Section 1',
                                  style: theme.textTheme.titleMedium),
                            ),
                          ),
                        ),
                        SliverCrossAxisGroup(
                          slivers: [
                            SliverCrossAxisExpanded(
                              flex: 1,
                              sliver: SliverGroup(),
                            ),
                            SliverConstrainedCrossAxis(
                              maxExtent: 400,
                              sliver: SliverFilters(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SliverCrossAxisExpanded(flex: 1, sliver: SliverGap(0)),
                ],
              );
            },
          ),
          SliverBar(
            maxExtent: 600,
            minExtent: 100,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: ShapeDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                alignment: Alignment.center,
                child: Text('Footer'),
              ),
            ),
          ),
          SliverMainAxisGroup(
            slivers: [
              SliverCrossAxisGroup(
                slivers: [
                  SliverConstrainedCrossAxis(
                    maxExtent: 400,
                    sliver: SliverFilters(),
                  ),
                  SliverCrossAxisExpanded(
                    flex: 1,
                    sliver: SliverSection2(),
                  ),
                ],
              ),
            ],
          ),
          SliverLayoutBuilder(builder: (context, constraints) {
            final remainingPaintExtent = constraints.remainingPaintExtent;
            return SliverOpacity(
              opacity: min(1, remainingPaintExtent / 600),
              sliver: SliverToBoxAdapter(
                child: Container(
                  height: 600,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: ShapeDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text('Footer'),
                ),
              ),
            );
          }),
          SliverFillViewport(
            delegate: SliverChildListDelegate.fixed([
              Container(
                height: 200,
                color: theme.colorScheme.primary,
                child: Center(
                  child: Text(
                    'Full size',
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class SliverFilters extends StatelessWidget {
  const SliverFilters({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverBar(
          pinned: true,
          maxExtent: 550,
          minExtent: 550,
          child: Padding(
            padding: EdgeInsets.all(12),
            child: DecoratedBox(
              decoration: ShapeDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Column(
                children: [
                  for (final filter
                      in List.generate(12, (index) => 'Filter $index'))
                    ListTile(
                      title: Text(filter),
                      dense: true,
                    ),
                ],
              ),
            ),
          ),
        ),
        SliverFillRemaining(),
      ],
    );
  }
}

class SliverSection2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverMainAxisGroup(slivers: [
      SliverPadding(
        padding: EdgeInsets.all(12),
        sliver: DecoratedSliver(
          decoration: ShapeDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          sliver: SliverTableView.builder(
            style: TableViewStyle(scrollPadding: EdgeInsets.all(12)),
            columns: [
              const TableColumn(
                width: 56.0,
                freezePriority: 100,
              ),
              for (var i = 1; i < 100; i++) const TableColumn(width: 64),
            ],
            rowCount: 100,
            rowHeight: 56.0,
            rowBuilder: (context, row, contentBuilder) {
              return InkWell(
                onTap: () => print('Row $row clicked'),
                child: contentBuilder(
                  context,
                  (context, column) =>
                      Center(child: Text('$column')), // build a cell widget
                ),
              );
            },
            headerBuilder: (context, contentBuilder) {
              return contentBuilder(
                context,
                (context, column) => Center(
                  child: Text('C$column'),
                ),
              );
            },
          ),
        ),
      ),
    ]);
  }
}

class SliverGroup extends StatelessWidget {
  const SliverGroup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverCrossAxisGroup(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.all(12),
          sliver: DecoratedSliver(
            decoration: ShapeDecoration(
              color: theme.colorScheme.surfaceContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            sliver: SliverList.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item $index'),
                  dense: true,
                );
              },
              itemCount: 30,
            ),
          ),
        ),
      ],
    );
  }
}

class SliverCustomDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      width: double.infinity,
      height: max(maxExtent - shrinkOffset, minExtent),
      color: Colors.grey,
      child: Center(
        child: Text(
          'Header',
        ),
      ),
    );
  }

  @override
  double get maxExtent => 200;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class SliverBar extends SliverPersistentHeader {
  SliverBar({
    super.key,
    required Widget child,
    required double maxExtent,
    required double minExtent,
    super.pinned,
    super.floating,
  }) : super(
          delegate: SliverFixedDelegate(child, maxExtent, minExtent),
        );
}

class SliverFixedDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  SliverFixedDelegate(this.child, this.maxExtent, this.minExtent);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      width: double.infinity,
      height: max(maxExtent - shrinkOffset, minExtent),
      child: child,
    );
  }

  @override
  final double maxExtent;

  @override
  final double minExtent;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class SliverSection extends StatelessWidget {
  const SliverSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(slivers: [
      SliverToBoxAdapter(
        child: Text('Title'),
      ),
      SliverList.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item $index'),
            dense: true,
          );
        },
        itemCount: 30,
      ),
    ]);
  }
}
