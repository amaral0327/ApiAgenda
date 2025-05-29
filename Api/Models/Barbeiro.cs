namespace ProjetoAgenda.Models
{
    public class Barbeiro
    {
        public int Id { get; set; }
        public required string Nome { get; set; }
        public string? Especialidade { get; set; }
    }
}