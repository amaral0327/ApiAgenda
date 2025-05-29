using System;

namespace ProjetoAgenda.Models
{
    public class Agendamento
    {
        public int Id { get; set; }

         //Relações
        public int ClienteId { get; set; }
        public required Cliente Cliente { get; set; }

        public int BardeiroId { get; set; }
        public required Barbeiro Barbeiro { get; set; }

        public DateTime DataHora { get; set; }
        public string? Observacoes { get; set; }
         
    }
}
