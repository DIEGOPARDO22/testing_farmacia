from django.shortcuts import render, redirect
from django.db import connection

cursor = connection.cursor() #cursor

def inicio(req):
    return render(req, 'inicio.html')

# ================================================================
#                          PRODUCTOS
# ================================================================

def productos(req):
    cursor.execute('CALL sp_listar_producto')
    data = cursor.fetchall()
    return render(req, 'productos/index.html',{'data': data})

def crear_producto(req):
    if req.method=="POST":
        if req.POST.get("producto_id") and req.POST.get("producto_nombre") and req.POST.get("producto_precio") and req.POST.get("producto_stock") and req.POST.get("producto_categoria"):
            id=req.POST.get("producto_id")
            nombre=req.POST.get("producto_nombre")
            precio=req.POST.get("producto_precio")
            stock=req.POST.get("producto_stock")
            categoria=req.POST.get("producto_categoria")

            cursor.execute("CALL sp_crear_producto('"+id+"','"+nombre+"','"+precio+"','"+stock+"','"+categoria+"')")
            return redirect ('productos')
    return render(req, 'productos/form.html')


def clientes(req):
    cursor.execute('CALL sp_listar_clientes')
    data = cursor.fetchall()
    return render(req, 'clientes/index.html',{'data':data})

def facturas(req):
    cursor.execute('CALL sp_listar_facturas')
    data = cursor.fetchall()
    return render(req, 'facturas/index.html',{'data':data})