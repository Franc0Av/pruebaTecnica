using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using pruebaTecnica.Models;

namespace pruebaTecnica.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DetalleProductosController : ControllerBase
    {
        private readonly PruebatecnicaContext _context;

        public DetalleProductosController(PruebatecnicaContext context)
        {
            _context = context;
        }

        // GET: api/DetalleProductos
        [HttpGet]
        public async Task<ActionResult<IEnumerable<DetalleProducto>>> GetDetalleProductos()
        {
          if (_context.DetalleProductos == null)
          {
              return NotFound();
          }
            return await _context.DetalleProductos.ToListAsync();
        }

        // GET: api/DetalleProductos/5
        [HttpGet("{id}")]
        public async Task<ActionResult<DetalleProducto>> GetDetalleProducto(int id)
        {
          if (_context.DetalleProductos == null)
          {
              return NotFound();
          }
            var detalleProducto = await _context.DetalleProductos.FindAsync(id);

            if (detalleProducto == null)
            {
                return NotFound();
            }

            return detalleProducto;
        }

        // GET: api/DetalleProductos/porPedido/{itemId}
        [HttpGet("porPedido/{itemId}")]
        public IActionResult GetDetalleProductosPorPedido(int itemId)
        {
            try
            {

                var detallesPorPedido = _context.Pedidos
                    .Where(p => p.ItemId == itemId)
                    .ToList();

                return Ok(detallesPorPedido);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Error interno del servidor: " + ex.Message);
            }
        }

        private bool DetalleProductoExists(int id)
        {
            return (_context.DetalleProductos?.Any(e => e.Id == id)).GetValueOrDefault();
        }
    }
}
