# threat_analysis_daemon.gd
extends Node

func calculate_threat_score() -> int:
	var recent_events = Chronicler.get_recent_events(100)
	var threat_score = 0
	for event in recent_events:
		if event["severity"] >= 3:
			threat_score += event["severity"]
	return threat_score

func score_to_threat_level(score: int) -> int:
	if score < 10:
		return Aegis.THREAT_LEVELS.MINIMAL
	elif score < 25:
		return Aegis.THREAT_LEVELS.LOW
	elif score < 50:
		return Aegis.THREAT_LEVELS.MODERATE
	elif score < 75:
		return Aegis.THREAT_LEVELS.HIGH
	else:
		return Aegis.THREAT_LEVELS.CRITICAL

func is_high_severity_event(event_data: Dictionary) -> bool:
	return event_data["severity"] >= 3

func is_potential_security_incident(event_data: Dictionary) -> bool:
	return event_data["severity"] >= 4 or event_data["event_type"] in ["unauthorized_access", "data_breach", "system_anomaly"]
