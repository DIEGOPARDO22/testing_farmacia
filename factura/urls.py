from django.urls import path
from . import views

urlpatterns = [
    path('', views.inicio, name='index'),
    path('productos', views.productos, name='productos')
]