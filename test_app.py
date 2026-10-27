
from app import security_status


def test_application_status():
    result = security_status()
    assert result["status"] == "healthy"


def test_security_checks_enabled():
    result = security_status()
    assert result["security_checks"] == "enabled"
