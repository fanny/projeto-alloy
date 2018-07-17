module hospital
abstract sig Funcionario {
	paciente: set Paciente
}
sig Medico extends Funcionario{}
sig Enfermeiro extends Funcionario{}

abstract sig Paciente{}
sig PacienteCirurgiado extends Paciente{} 
sig PacienteNaoCirurgiado extends Paciente{}

fact relacaoFuncionarioPaciente{
	all f: Funcionario | #f.paciente < 6 
}

fact atendimentoPacienteCirurgiado{
	all p:PacienteCirurgiado  | funcionariosDoPacienteCirurgiado[p]
}

fact atendimentoPacienteNaoCirurgiado{
	all p:PacienteNaoCirurgiado  | funcionariosDoPacienteNaoCirurgiado[p]
}

pred funcionariosDoPacienteCirurgiado[p: PacienteCirurgiado]{
	one getMedicosPacienteCirurgiado[p]
	#(getEnfermeiroPacienteCirurgiado [p])=2
}

pred funcionariosDoPacienteNaoCirurgiado[p: PacienteNaoCirurgiado]{
	no getMedicosPacienteNaoCirurgiado[p]
	one getEnfermeiroPacienteNaoCirurgiado[p]
}

fun getMedicosPacienteCirurgiado [p: PacienteCirurgiado] : set Medico {
    Medico & p.~paciente
}

fun getEnfermeiroPacienteCirurgiado [p: PacienteCirurgiado] : set Enfermeiro {
    Enfermeiro & p.~paciente
}
fun getEnfermeiroPacienteNaoCirurgiado [p: PacienteNaoCirurgiado] : set Enfermeiro {
    Enfermeiro & p.~paciente
}

fun getMedicosPacienteNaoCirurgiado [p: PacienteNaoCirurgiado] : set Medico {
    Medico & p.~paciente
}

pred show[]{}
run show for 60
