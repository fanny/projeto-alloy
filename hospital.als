module hospital

-----------------------------------------------------------------------------------------------------------
-- ASSINATURAS
-----------------------------------------------------------------------------------------------------------

abstract sig Funcionario {
	paciente: set Paciente
}

sig Medico extends Funcionario{}

sig Enfermeiro extends Funcionario{}

abstract sig Paciente{}

sig PacienteCirurgiado extends Paciente{} 

sig PacienteNaoCirurgiado extends Paciente{}

-----------------------------------------------------------------------------------------------------------
-- FATOS
-----------------------------------------------------------------------------------------------------------

fact relacaoFuncionarioPaciente{
	all f: Funcionario | #f.paciente < 6 
}

fact atendimentoPacienteCirurgiado{
	all p:PacienteCirurgiado  | funcionariosDoPacienteCirurgiado[p]
}

fact atendimentoPacienteNaoCirurgiado{
	all p:PacienteNaoCirurgiado  | funcionariosDoPacienteNaoCirurgiado[p]
}

-----------------------------------------------------------------------------------------------------------
-- PREDICADOS
-----------------------------------------------------------------------------------------------------------

pred funcionariosDoPacienteCirurgiado[p: PacienteCirurgiado]{
	one getMedicosPacienteCirurgiado[p]
	#(getEnfermeiroPacienteCirurgiado [p])=2
}

pred funcionariosDoPacienteNaoCirurgiado[p: PacienteNaoCirurgiado]{
	no getMedicosPacienteNaoCirurgiado[p]
	one getEnfermeiroPacienteNaoCirurgiado[p]
}

-----------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------

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

-----------------------------------------------------------------------------------------------------------
-- TESTES
-----------------------------------------------------------------------------------------------------------

assert testPacienteTemNoMinimoUmEnfermeiro{
	all p : Paciente | #(Enfermeiro & p.~paciente) > 0
}

check testPacienteTemNoMinimoUmEnfermeiro for 20

assert testPacienteCirurgiadoTemDoisEnfermeiros{
	all p : PacienteCirurgiado | #(Enfermeiro & p.~paciente) = 2
}

check testPacienteCirurgiadoTemDoisEnfermeiros for 20

assert testPacienteCirurgiadoTemUmMedico{
	all p : PacienteCirurgiado | #(Medico & p.~paciente) = 1
}

check testPacienteCirurgiadoTemUmMedico for 20

assert testPacienteNaoCirurgiadoTemUmEnfermeiro{
	all p : PacienteNaoCirurgiado | #(Enfermeiro & p.~paciente) = 1
}

check testPacienteNaoCirurgiadoTemUmEnfermeiro for 20

assert testEnfermeiroTemNoMaximoCincoPacientes{
	all e : Enfermeiro | #e.paciente <= 5
}

check testEnfermeiroTemNoMaximoCincoPacientes for 20

assert testMedicoTemNoMaximoCincoPacientes{
	all m : Medico | #m.paciente <= 5
}

check testMedicoTemNoMaximoCincoPacientes for 20

assert testeFuncionarios{
	Funcionario = Medico + Enfermeiro
}

check testeFuncionarios for 20

assert testePacientes{
	Paciente = PacienteCirurgiado + PacienteNaoCirurgiado
}

check testePacientes for 20

pred show[]{}
run show for 20
