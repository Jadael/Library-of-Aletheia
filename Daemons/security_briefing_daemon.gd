# A COMPUTER CAN NEVER BE HELD ACCOUNTABLE
# THEREFORE A COMPUTER MUST NEVER MAKE A MANAGEMENT DECISION
# security_briefing_daemon.gd
extends Node
const NAME = "👩‍🏫 Security Briefing Daemon"

func generate_briefing(threat_level: int, active_alerts: Array, current_protocols: Dictionary) -> String:
	var briefing = "Security Briefing\n"
	briefing += "================\n\n"
	
	briefing += "Current Threat Level: " + Aegis.THREAT_LEVELS.keys()[threat_level] + "\n\n"
	
	briefing += "Recent High-Severity Events:\n"
	var recent_events = Chronicler.generate_recent_events_report(3600, 3)
	briefing += recent_events + "\n"
	
	briefing += "Active Alerts:\n"
	for alert in active_alerts:
		briefing += "- " + alert.get("type", "Unknown") + ": " + alert.get("description", "No description") + "\n"
	briefing += "\n"
	
	briefing += "Current Security Protocols:\n"
	for protocol in current_protocols:
		briefing += "- " + protocol + ": " + str(current_protocols[protocol]) + "\n"
	briefing += "\n"
	
	briefing += "Recommendations:\n"
	if threat_level >= Aegis.THREAT_LEVELS.HIGH:
		briefing += "- All entities should be on high alert.\n"
		briefing += "- Non-essential operations should be minimized.\n"
	elif threat_level == Aegis.THREAT_LEVELS.MODERATE:
		briefing += "- Increase vigilance and double-check unusual operations.\n"
		briefing += "- Review access controls for critical systems.\n"
	else:
		briefing += "- Maintain normal operations but stay alert.\n"
		briefing += "- Conduct regular security training.\n"
	
	return briefing
