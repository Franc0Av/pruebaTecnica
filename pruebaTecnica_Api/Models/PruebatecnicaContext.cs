using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace pruebaTecnica.Models;

public partial class PruebatecnicaContext : DbContext
{
    public PruebatecnicaContext()
    {
    }

    public PruebatecnicaContext(DbContextOptions<PruebatecnicaContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Contrato> Contratos { get; set; }

    public virtual DbSet<DetalleProducto> DetalleProductos { get; set; }

    public virtual DbSet<Pedido> Pedidos { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder
            .UseCollation("utf8mb3_general_ci")
            .HasCharSet("utf8mb3");

        modelBuilder.Entity<Contrato>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("contratos");

            entity.HasIndex(e => e.CourseCode, "CourseCode_UNIQUE").IsUnique();

            entity.Property(e => e.ColegioCurso).HasMaxLength(45);
            entity.Property(e => e.ColegioLocalidad).HasMaxLength(45);
            entity.Property(e => e.ColegioNivel).HasMaxLength(45);
            entity.Property(e => e.ColegioNombre).HasMaxLength(45);
            entity.Property(e => e.CourseCode).HasMaxLength(50);
            entity.Property(e => e.FechaAlta).HasColumnType("datetime");
            entity.Property(e => e.FechaEntrega).HasColumnType("datetime");
            entity.Property(e => e.MedioEntrega).HasMaxLength(45);
            entity.Property(e => e.Total).HasPrecision(8, 2);
            entity.Property(e => e.Vendedor).HasMaxLength(45);
        });

        modelBuilder.Entity<DetalleProducto>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("detalle_producto");

            entity.Property(e => e.Nombre).HasMaxLength(45);
            entity.Property(e => e.Precio).HasPrecision(8, 2);
        });

        modelBuilder.Entity<Pedido>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("pedidos");

            entity.HasIndex(e => e.ContractId, "ContractId_idx");

            entity.HasIndex(e => e.ItemId, "ItemId_idx");

            entity.Property(e => e.CreateDate).HasColumnType("datetime");
            entity.Property(e => e.CreatedBy).HasMaxLength(45);
            entity.Property(e => e.UpdateDate).HasColumnType("datetime");

            entity.HasOne(d => d.Contract).WithMany(p => p.Pedidos)
                .HasForeignKey(d => d.ContractId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("ContractId");

            entity.HasOne(d => d.Item).WithMany(p => p.Pedidos)
                .HasForeignKey(d => d.ItemId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("ItemId");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
