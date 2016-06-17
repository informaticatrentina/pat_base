<?php


class ITOpenDataProvider extends OCOpenDataProvider
{
    public function getVersion1Routes()
    {
        $routes = array(
            'ezpListAtom' => new ezpRestVersionedRoute(
                new ezpMvcRailsRoute(
                    '/content/node/:nodeId/listAtom',
                    'ezpRestAtomController',
                    'collection'
                ), 1
            ),
            // @TODO : Make possible to interchange optional params positions
            'ezpList' => new ezpRestVersionedRoute(
                new ezpMvcRegexpRoute(
                    '@^/content/node/(?P<nodeId>\d+)/list(?:/offset/(?P<offset>\d+))?(?:/limit/(?P<limit>\d+))?(?:/sort/(?P<sortKey>\w+)(?:/(?P<sortType>asc|desc))?)?$@',
                    'ITOpenDataController',
                    'list',
                    array(
                        'offset' => 0,
                        'limit' => 10
                    )
                ), 1
            ),
            'ezpNode' => new ezpRestVersionedRoute(
                new ezpMvcRailsRoute(
                    '/content/node/:nodeId', 'ITOpenDataController', 'viewContent'
                ), 1
            ),
            'ezpFieldsByNode' => new ezpRestVersionedRoute(
                new ezpMvcRailsRoute(
                    '/content/node/:nodeId/fields',
                    'ITOpenDataController',
                    'viewFields'
                ), 1
            ),
            'ezpFieldByNode' => new ezpRestVersionedRoute(
                new ezpMvcRailsRoute(
                    '/content/node/:nodeId/field/:fieldIdentifier',
                    'ITOpenDataController',
                    'viewField'
                ), 1
            ),
            'ezpChildrenCount' => new ezpRestVersionedRoute(
                new ezpMvcRailsRoute(
                    '/content/node/:nodeId/childrenCount',
                    'ITOpenDataController',
                    'countChildren'
                ), 1
            ),
            'ezpObject' => new ezpRestVersionedRoute(
                new ezpMvcRailsRoute(
                    '/content/object/:objectId',
                    'ITOpenDataController',
                    'viewContent'
                ), 1
            ),
            'ezpFieldsByObject' => new ezpRestVersionedRoute(
                new ezpMvcRailsRoute(
                    '/content/object/:objectId/fields',
                    'ITOpenDataController',
                    'viewFields'
                ), 1
            ),
            'ezpFieldByObject' => new ezpRestVersionedRoute(
                new ezpMvcRailsRoute(
                    '/content/object/:objectId/field/:fieldIdentifier',
                    'ITOpenDataController',
                    'viewField'
                ), 1
            )
        );

        $routes['openDataListByClass'] = new ezpRestVersionedRoute(
            new ezpMvcRegexpRoute(
            //'@^/content/class/(?P<classIdentifier>\w+)(?:/offset/(?P<offset>\d+))?(?:/limit/(?P<limit>\d+))?(?:/sort/(?P<sortKey>\w+)(?:/(?P<sortType>asc|desc))?)?$@',
                '@^/content/class/(?P<classIdentifier>\w+)(?:/offset/(?P<offset>\d+))?(?:/limit/(?P<limit>\d+))?$@',
                'ITOpenDataController',
                'listByClass',
                array(
                    'offset' => 0,
                    'limit' => 10
                )
            ), 1
        );

        $routes['openDataClassList'] = new ezpRestVersionedRoute(
            new ezpMvcRailsRoute( '/content/classList', 'ITOpenDataController', 'listClasses' ), 1
        );
        $routes['openDataInstantiatedClassList'] = new ezpRestVersionedRoute(
            new ezpMvcRailsRoute(
                '/content/instantiatedClassList',
                'ITOpenDataController',
                'instantiatedListClasses'
            ), 1
        );

        $routes['openDataHelp'] = new ezpRestVersionedRoute(
            new ezpMvcRailsRoute( '/', 'ITOpenDataController', 'help' ), 1
        );
        $routes['openDataHelpList'] = new ezpRestVersionedRoute(
            new ezpMvcRailsRoute( '/help', 'ITOpenDataController', 'helpList' ), 1
        );

        $routes['openDataDataset'] = new ezpRestVersionedRoute(
            new ezpMvcRailsRoute( '/dataset', 'ITOpenDataController', 'datasetList' ), 1
        );
        $routes['openDataDatasetView'] = new ezpRestVersionedRoute(
            new ezpMvcRailsRoute( '/dataset/:datasetId', 'ITOpenDataController', 'datasetView' ), 1
        );

        return $routes;
    }

}
