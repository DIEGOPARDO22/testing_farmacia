from django.shortcuts import render, redirect
from django.db import connection
import pyautogui
import time
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
            cursor.execute("CALL sp_crear_producto('"+nombre+"','"+(precio)+"','"+stock+"','"+categoria+"')")
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
        if req.POST.get("cliente_ruc") and req.POST.get("cliente_razon") and req.POST.get("cliente_direccion") and req.POST.get("cliente_telefono") and req.POST.get("cliente_email"):
            ruc = req.POST.get("cliente_ruc")
            razon = req.POST.get("cliente_razon")
            direccion = req.POST.get("cliente_direccion")
            telefono = req.POST.get("cliente_telefono")
            email = req.POST.get("cliente_email")

            cursor.execute("CALL sp_crear_cliente('"+ruc+"','"+razon+"','"+direccion+"','"+telefono+"','"+email+"')")
            return redirect('clientes')
    return render(req, 'clientes/form.html')

def editar_cliente(req, id):
    cursor.execute("CALL sp_buscar_cliente_por_id('"+id+"')")
    data = cursor.fetchall()
    if req.method == "POST":
        if req.POST.get("cliente_ruc") and req.POST.get("cliente_razon") and req.POST.get("cliente_direccion") and req.POST.get("cliente_telefono") and req.POST.get("cliente_email"):
            ruc = req.POST.get("cliente_ruc")
            razon = req.POST.get("cliente_razon")
            direccion = req.POST.get("cliente_direccion")
            telefono = req.POST.get("cliente_telefono")
            email = req.POST.get("cliente_email")

            cursor.execute("CALL sp_editar_cliente('"+ruc+"','"+razon+"','"+direccion+"','"+telefono+"','"+email+"')")
            return redirect('clientes')
    return render(req, 'clientes/form.html',{'data':data})

def eliminar_cliente(req, id):
    cursor.execute("CALL sp_eliminar_cliente('"+id+"')")
    return redirect('clientes')

# ================================================================
#                          FACTURAS
# ================================================================

def facturas(req):
    cursor.execute('CALL sp_listar_facturas')
    data = cursor.fetchall()
    return render(req, 'facturas/index.html', {'data': data})

def crear_factura_y_detalle(req):
    cursor.execute('CALL sp_listar_clientes')
    clientes_lista = cursor.fetchall()

    cursor.execute('CALL sp_listar_producto')
    productos_lista = cursor.fetchall()
    
    if req.method == "POST":
        # Manejar la creación de la factura
        if req.POST.get("ruc") and req.POST.get("fecha"):
            ruc = req.POST.get("ruc")
            fecha = req.POST.get("fecha")
            cursor.execute("CALL sp_crear_factura('" + ruc + "','" + fecha + "')")
            # Manejar la creación del detalle
            if req.POST.get("id_producto[]") and req.POST.get("cantidad[]"):
                cursor.execute('CALL sp_ver_ultima_factura')
                ultimo_num_factura  = cursor.fetchall()
                num_factura = ultimo_num_factura[0][0]

                id_producto = req.POST.getlist("id_producto[]")
                cantidad = req.POST.getlist("cantidad[]")
                for i in range(len(id_producto)):
                    cursor.execute("CALL sp_crear_detalle('" + str(num_factura) + "','" + str(id_producto[i]) + "','" + str(cantidad[i]) + "')")
                return redirect('facturas')
            else:
                return redirect('crear_factura_y_detalle')
        else:
            return redirect('crear_factura_y_detalle')
    else:
        return render(req, 'facturas/form.html', {'ruc': clientes_lista, 'id_producto': productos_lista})

def eliminar_facturas(req, id):
    cursor.execute("call sp_eliminar_factura('"+id+"')")
    return redirect ('facturas')
def ver_factura(req, id):
    cursor.execute("call sp_ver_factura(%s)", (id,))
    data = cursor.fetchall()
    print("esta es la data:", data)
    nuevos_datos = []
    suma_importe_total = 0
    suma_total_venta = 0
    suma_total_igv = 0
    suma_total_descuento = 0# initialize the variable outside the for loop
    for d in data:
        total_venta = float(d[6]) * int(d[5])
        descuento = total_venta * 0.01
        total_igv = total_venta * 0.18
        importe_total = total_venta + total_igv - descuento
        suma_importe_total += importe_total  # add the value to the variable
        suma_total_venta += total_venta
        suma_total_igv += total_igv # add the value to the variable
        suma_total_descuento += descuento # add the value to the variable
        nuevos_datos.append((d[0], d[1], d[2], d[3], d[4], d[5], d[6], importe_total))
    print(nuevos_datos)
    return render(req, 'facturas/preliminar.html', {'data': data, 'suma_total_igv': suma_total_igv, 'suma_importe_total': suma_importe_total, 'suma_total_descuento': suma_total_descuento, 'suma_total_venta': suma_total_venta, 'nuevos_datos': nuevos_datos})



def print_fact(req):
    try:
        pyautogui.hotkey('ctrl', 'p')
        time.sleep(300)
        return render(req, 'inicio.html')
    except Exception as e:
        print(f"Error: {e}")