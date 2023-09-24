using System;
using System.Collections.Generic;

namespace pruebaTecnica.Models;

public partial class DetalleProducto
{
    public int Id { get; set; }

    public string Nombre { get; set; } = null!;

    public decimal Precio { get; set; }

    public virtual ICollection<Pedido> Pedidos { get; set; } = new List<Pedido>();
}
