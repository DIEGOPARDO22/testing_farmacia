from django.shortcuts import render, redirect
from django.db import connection

cursor = connection.cursor()  # cursor


def inicio(req):
    return render(req, 'inicio.html')

# ================================================================
#                          PRODUCTOS
# ================================================================


def productos(req):
    cursor.execute('CALL sp_listar_producto')
    data = cursor.fetchall()
    return render(req, 'productos/index.html', {'data': data})


def crear_producto(req):
    cursor.execute('CALL sp_listar_categorias')
    cat = cursor.fetchall()
    if req.method == "POST":
        if req.POST.get("producto_nombre") and req.POST.get("producto_precio") and req.POST.get("producto_stock") and req.POST.get("producto_categoria"):
            nombre = req.POST.get("producto_nombre")
            precio = req.POST.get("producto_precio")
            stock = req.POST.get("producto_stock")
            categoria = req.POST.get("producto_categoria")

            cursor.execute("CALL sp_crear_producto('"+nombre+"','"+precio+"','"+stock+"','"+categoria+"')")
            return redirect('productos')
    return render(req, 'productos/form.html', {'categoria': cat})


def editar_producto(req, id):
    cursor.execute("CALL sp_buscar_producto_por_id('"+id+"')")
    data = cursor.fetchall()
    cursor.execute('CALL sp_listar_categorias')
    cat = cursor.fetchall()
    
    if req.method == "POST":
        if req.POST.get("producto_nombre") and req.POST.get("producto_precio") and req.POST.get("producto_stock") and req.POST.get("producto_categoria"):
            nombre = req.POST.get("producto_nombre")
            precio = req.POST.get("producto_precio")
            stock = req.POST.get("producto_stock")
            categoria = req.POST.get("producto_categoria")

            cursor.execute("CALL sp_editar_producto('"+str(data[0][0])+"','"+nombre+"','"+precio+"','"+stock+"','"+categoria+"')")
            return redirect('productos')
        
    return render(req, 'productos/form.html', {'data':data, 'categoria':cat})

def eliminar_producto(req, id):
    cursor.execute("CALL sp_eliminar_producto('"+id+"')")
    return redirect('productos')



# ================================================================
#                          CLIENTES
# ================================================================


def clientes(req):
    cursor.execute('CALL sp_listar_clientes')
    data = cursor.fetchall()
    return render(req, 'clientes/index.html', {'data': data})


def crear_cliente(req):
    if req.method == "POST":
        if req.POST.get("id_cliente") and req.POST.get("nombres") and req.POST.get("apellidos") and req.POST.get("direccion") and req.POST.get("fecha_nacimiento") and req.POST.get("telefono") and req.POST.get("email"):
            id_cliente = req.POST.get("id_cliente")
            nombres = req.POST.get("nombres")
            apellidos = req.POST.get("apellidos")
            direccion = req.POST.get("direccion")
            fecha_nacimiento = req.POST.get("fecha_nacimiento")
            telefono = req.POST.get("telefono")
            email = req.POST.get("email")

            cursor.execute("CALL sp_crear_producto('"+id_cliente+"','"+nombres+"','"+apellidos +
                           "','"+direccion+"','"+fecha_nacimiento+"','"+telefono+"','"+email+"')")
            return redirect('clientes')
    return render(req, 'clientes/form.html')


# ================================================================
#                          FACTURAS
# ================================================================

def facturas(req):
    cursor.execute('CALL sp_listar_facturas')
    data = cursor.fetchall()
    return render(req, 'facturas/index.html', {'data': data})


def crear_factura(req):
    if req.method == "POST":
        if req.POST.get("num_factura") and req.POST.get("id_cliente") and req.POST.get("fecha"):
            num_factura = req.POST.get("num_factura")
            id_cliente = req.POST.get("id_cliente")
            fecha = req.POST.get("fecha")

            cursor.execute("CALL sp_crear_producto('" +
                           num_factura+"','"+id_cliente+"','"+fecha+"')")
            return redirect('facturas')
    return render(req, 'facturas/form.html')

def eliminar_facturas(req, id):
    cursor.execute("call sp_eliminar_factura('"+id+"')")
    return redirect ('facturas')
    