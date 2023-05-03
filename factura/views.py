from django.shortcuts import render, redirect
from django.db import connection
cursor = connection.cursor()

# Create your views here.
def inicio(req):
    return render(req, 'inicio.html')

def productos(req):
    cursor.execute('CALL sp_listar_producto')
    data = cursor.fetchall()
    return render(req, 'productos/index.html',{'data': data})
