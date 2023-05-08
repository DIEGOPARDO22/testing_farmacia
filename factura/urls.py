from django.urls import path
from . import views

urlpatterns = [
    path('', views.inicio, name='index'),
    
    # PRODUCTOS
    path('productos', views.productos, name='productos'),
    path('productos/crear-producto/', views.crear_producto, name='crear_producto'),
    path('productos/editar-producto', views.editar_producto, name='editar_producto'),
    path('productos/editar-producto/<str:id>', views.editar_producto, name='editar_producto'),       
    path('productos/eliminar/<str:id>', views.eliminar_producto, name='eliminar_producto'),
    
    # CLIENTES
    path('clientes', views.clientes, name='clientes'),
    path('clientes/crear-cliente', views.crear_cliente, name='crear_cliente'),
    path('clientes/editar-cliente', views.editar_cliente, name='editar_cliente'),
    path('clientes/editar-cliente/<str:id>', views.editar_cliente, name='editar_cliente'),
    path('clientes/eliminar/<str:id>', views.eliminar_cliente, name='eliminar_cliente'),
    
    
    # FACTURAS
    path('facturas', views.facturas, name='facturas'),
    path('facturas/crear_factura_y_detalle', views.crear_factura_y_detalle, name='crear_factura_y_detalle'),
    path('facturas/eliminar/<str:id>', views.eliminar_facturas, name='eliminar_facturas'),
    path('facturas/mostrar-factura/<str:id>', views.ver_factura, name='ver_factura'),
    path('facturas/mostrar-factura/imprimir/', views.print_fact, name='print_fact'),


]