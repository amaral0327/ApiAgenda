using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProjetoAgenda.Data;
using ProjetoAgenda.Models;

namespace ProjetoAgenda.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class BarbeirosController : ControllerBase
    {
        private readonly AppDbContext _context;

        public BarbeirosController(AppDbContext context)
        {
            _context = context;
        }
        //GET: api/Barbeiro
        [HttpGet]
        public ActionResult<IEnumerable<Barbeiro>> GetBarbeiros()
        {
            return Ok(_context.Barbeiros.ToList());
        }

        //GET: api/Barbeiros/5
        [HttpGet("{id}")]
        public ActionResult<Barbeiro> GetBarbeiro(int id) 
        {
            var barbeiro = _context.Barbeiros.Find(id);

            if (barbeiro == null)
                return NotFound();

            return Ok(barbeiro);
        }

        //POST: api/Barbeiro
        [HttpPost]
        public ActionResult<Barbeiro> PostBarbeiro(Barbeiro barbeiro)
        {
            _context.Barbeiros.Add(barbeiro);
            _context.SaveChanges();

            return CreatedAtAction(nameof(GetBarbeiro), new { id = barbeiro.Id }, barbeiro);
        }

        //PUT: api/Barbeiro/5
        [HttpPut("{id}")]
        public IActionResult PutBarbeiro(int id, Barbeiro barbeiro)
        {
            if (id != barbeiro.Id)
                return BadRequest();

            _context.Barbeiros.Update(barbeiro);
            _context.SaveChanges();

            return NoContent();
        }

        //DELETE: api/Barbeiro/5
        [HttpDelete("{id}")]
        public IActionResult DeleteBarbeiro(int id)
        {
            var barbeiro = _context.Barbeiros.Find(id);
            if (barbeiro == null)
                return NotFound();

            _context.Barbeiros.Remove(barbeiro);
            _context.SaveChanges();

            return NoContent();
        }
    }
}
