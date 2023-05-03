from django.shortcuts import render, redirect
from django.db import connection
cursor = connection.cursor()

def inicio(req):
    return render(req, 'inicio.html')

def productos(req):
    cursor.execute('CALL sp_listar_producto')
    data = cursor.fetchall()
    return render(req, 'productos/index.html',{'data': data})

def clientes(req):
    cursor.execute('CALL sp_listar_clientes')
    data = cursor.fetchall()
    return render(req, 'clientes/index.html',{'data':data})