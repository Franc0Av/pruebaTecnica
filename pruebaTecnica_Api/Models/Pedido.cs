using System;
using System.Collections.Generic;

namespace pruebaTecnica.Models;

public partial class Pedido
{
    public int Id { get; set; }

    public int ContractId { get; set; }

    public int ItemId { get; set; }

    public DateTime CreateDate { get; set; }

    public DateTime? UpdateDate { get; set; }

    public int Enabled { get; set; }

    public int Deleted { get; set; }

    public string CreatedBy { get; set; } = null!;

    public virtual Contrato Contract { get; set; } = null!;

    public virtual DetalleProducto Item { get; set; } = null!;
}
