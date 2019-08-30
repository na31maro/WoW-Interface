﻿if not ACP then return end

--@non-debug@

if (GetLocale() == "ptBR") then
	ACP:UpdateLocale(

L = {
	["*** Enabling <%s> %s your UI ***"] = "*** Ativando <%s> %s sua UI ***",
	["*** Unknown Addon <%s> Required ***"] = "*** Addon desconhecido <%s> Necessário ***",
	["ACP: Some protected addons aren't loaded. Reload now?"] = "ACP: Alguns addons protegidos não foram carregados. Recarregar agora?",
	["Active Embeds"] = "Embutidos ativos",
	["Add to current selection"] = "Adicionar à seleção atual",
	["Addon <%s> not valid"] = "Addon <%s> não é válido",
	["AddOns"] = "AddOns",
	["Addons [%s] Loaded."] = "Addons [%s] Carregados.",
	["Addons [%s] renamed to [%s]."] = "Addons [%s] renomeados para [%s].",
	["Addons [%s] Saved."] = "Addons [%s] Salvos.",
	["Addons [%s] Unloaded."] = "Addons [%s] não carregados.",
	["Author"] = "Autor",
	["Blizzard_AchievementUI"] = "Blizzard: Conquistas",
	["Blizzard_AuctionUI"] = "Blizzard: Leilão",
	["Blizzard_BarbershopUI"] = "Blizzard: Barbearia",
	["Blizzard_BattlefieldMinimap"] = "Blizzard: Minimapa de Campo de Batalha",
	["Blizzard_BindingUI"] = "Blizzard: Atalhos",
	["Blizzard_Calendar"] = "Blizzard: Calendário",
	["Blizzard_CombatLog"] = "Blizzard: Registro de Combate",
	["Blizzard_CombatText"] = "Blizzard: Textos de combate",
	["Blizzard_FeedbackUI"] = "Blizzard: Feedback",
	["Blizzard_GlyphUI"] = "Blizzard: Glifo",
	["Blizzard_GMSurveyUI"] = "Blizzard: Pesquisa de MJ",
	["Blizzard_GuildBankUI"] = "Blizzard: Banco da guilda",
	["Blizzard_InspectUI"] = "Blizzard: Inspecionar",
	["Blizzard_ItemSocketingUI"] = "Blizzard: Engaste de itens",
	["Blizzard_MacroUI"] = "Blizzard: Macro",
	["Blizzard_RaidUI"] = "Blizzard: Raide",
	["Blizzard_TalentUI"] = "Blizzard: Talento",
	["Blizzard_TimeManager"] = "Blizzard: Gerenciador de Tempo",
	["Blizzard_TokenUI"] = "Blizzard: Token",
	["Blizzard_TradeSkillUI"] = "Blizzard: Trade Skill",
	["Blizzard_TrainerUI"] = "Blizzard: Trainer",
	["Blizzard_VehicleUI"] = "Blizzard: Vehicle",
	["Click to enable protect mode. Protected addons will not be disabled"] = "Clique para ativar o modo protegido. Addons protegidos não serão desativados",
	["Close"] = "Fechar",
	["Default"] = "Padrão",
	["Dependencies"] = "Dependências",
	["Disable All"] = "Desativar Todos",
	["Disabled on reloadUI"] = "Será desativado ao recarregar a IU",
	["Embeds"] = "Embutidos",
	["Enable All"] = "Ativar Todos",
	["Enter the new name for [%s]:"] = "Escreva o novo nome para [%s]:",
	["Load"] = "Carregar",
	["Loadable OnDemand"] = "Carregável quando necessário",
	["Loaded"] = "Carregado",
	["Loaded on demand."] = "Carregado quando necessário",
	["LoD Child Enable is now %s"] = "Ativar dependentes %s",
	["Memory Usage"] = "Uso de Memória",
	["No information available."] = "Sem informações disponíveis",
	["Recursive"] = "Repetição",
	["Recursive Enable is now %s"] = "Repetição Habilitada: %s",
	["Reload"] = "Recarregar",
	["Reload your User Interface?"] = "Recarregar sua Interface de Usuario?",
	["ReloadUI"] = "Recarregar IU",
	["Remove from current selection"] = "Remover da seleção atual",
	["Rename"] = "Renomear",
	["Resurse-ToolTip"] = "Ao ativar um addon, tente habilitar qualquer dependência.",
	["Save"] = "Salvar",
	["Save the current addon list to [%s]?"] = "Salvar a lista atual de addons para [%s]?",
	["Set "] = "Conjunto",
	["Sets"] = "Conjuntos",
	["Status"] = "Status",
	["Use SHIFT to override the current enabling of dependancies behaviour."] = "Use SHIFT para substituir o comportamento da ativação de dependências atual.",
	["Version"] = "Versão",
	["when performing a reloadui."] = "quando recarregar a interface."
}


    )
end

--@end-non-debug@