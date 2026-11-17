
<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */

$routes->get('/', 'Home::index');

$routes->group('api', function($routes) {
    $routes->options('umkm', static function () {
        return service('response')->setStatusCode(204);
    });

    $routes->options('umkm/(:num)', static function () {
        return service('response')->setStatusCode(204);
    });

    $routes->get('umkm', 'Umkm::index');
    $routes->get('umkm/(:num)', 'Umkm::show/$1');
    $routes->post('umkm', 'Umkm::create');
    $routes->put('umkm/(:num)', 'Umkm::update/$1');
    $routes->delete('umkm/(:num)', 'Umkm::delete/$1');
});
