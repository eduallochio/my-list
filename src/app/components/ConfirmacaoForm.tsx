// components/ConfirmationForm.tsx

import React, { useState } from 'react';
//Certifique-se de ajustar o caminho para o seu cliente Prisma

const ConfirmacaoForm: React.FC = () => {
	const [name, setName] = useState('');
	const [confirmacao, setConfirmacao] = useState('');
	const [confirmacaoMessage, setConfirmacaoMessage] = useState('');

	const submitForm = async () => {
		if (name && confirmacao) {
			try {
				// interagir com o Prisma para salvar os dados no banco de dados
				await prisma.ConfirmedGuest.create({ data: { name, confirmacao } });

				setConfirmacaoMessage(
					`Obrigado, ${name}! Sua presença foi ${confirmacao === 'sim' ? 'confirmada' : 'cancelada'
					}.`
				);
			} catch (error) {
				console.error('Erro ao salvar no banco de dados:', error);
				setConfirmacaoMessage('Ocorreu um erro ao processar sua confirmação.');
			}
		} else {
			setConfirmacaoMessage('Por favor, preencha todos os campos.');
		}
	};

	return (
		<div className="container">
			<h2>Confirmação de Presença</h2>
			<p>Olá, convidado! Por favor, confirme sua presença:</p>
			<form>
				<label htmlFor="name">Seu Nome:</label>
				<input
					type="text"
					id="name"
					value={name}
					onChange={(e) => setName(e.target.value)}
					required
				/>

				<label htmlFor="confirmacao">Confirmar Presença:</label>
				<select
					id="confirmacao"
					value={confirmacao}
					onChange={(e) => setConfirmacao(e.target.value)}
					required
				>
					<option value="">Selecione...</option>
					<option value="sim">Sim, estarei presente</option>
					<option value="nao">Não poderei comparecer</option>
				</select>

				<button type="button" onClick={submitForm}>
					Confirmar
				</button>
			</form>

			<div id="confirmacaoMessage">{confirmacaoMessage}</div>
		</div>
	);
};

export default ConfirmacaoForm;
