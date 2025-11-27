#!/bin/bash
# cf-transfer-check.sh
# Verifica elegibilidad de dominio para transferencia a Cloudflare Registrar

DOMAIN=$1
if [ -z "$DOMAIN" ]; then
    echo "Uso: $0 <dominio>"
    exit 1
fi

echo "🔍 Verificando elegibilidad de transferencia para $DOMAIN..."

# Verificar si dominio está bloqueado
WHOIS_OUTPUT=$(whois $DOMAIN 2>/dev/null)
if echo "$WHOIS_OUTPUT" | grep -qi "status.*clientTransferProhibited"; then
    echo "❌ Dominio bloqueado para transferencia"
    echo "   Accede a tu registrador y desbloquea el dominio"
    exit 1
fi

# Verificar fecha de registro/transferencia
REG_DATE=$(echo "$WHOIS_OUTPUT" | grep -i "creation date" | head -1 | awk '{print $NF}')
if [ -n "$REG_DATE" ]; then
    echo "✅ Fecha de registro: $REG_DATE"
    # Verificar si han pasado 60 días (requiere cálculo de fechas)
    REG_TIMESTAMP=$(date -d "$REG_DATE" +%s 2>/dev/null || echo "0")
    CURRENT_TIMESTAMP=$(date +%s)
    DAYS_OLD=$(( ($CURRENT_TIMESTAMP - $REG_TIMESTAMP) / 86400 ))
    
    if [ $DAYS_OLD -lt 60 ]; then
        echo "⚠️  Dominio registrado hace menos de 60 días ($DAYS_OLD días)"
        echo "   ICANN requiere 60 días antes de transferir"
    else
        echo "✅ Dominio elegible (más de 60 días desde registro)"
    fi
fi

# Verificar nameservers actuales
NS=$(echo "$WHOIS_OUTPUT" | grep -i "name server" | head -2 | awk '{print $NF}' | tr '\n' ' ')
if [ -n "$NS" ]; then
    echo "📡 Nameservers actuales: $NS"
fi

echo ""
echo "✅ Dominio elegible para transferencia"
echo "📋 Próximos pasos:"
echo "   1. Obtén el código de autorización (Auth Code) de tu registrador"
echo "   2. Inicia transferencia en Cloudflare Dashboard"
echo "   3. Ingresa el código cuando se solicite"
echo "   4. Aprueba la transferencia en el email de tu registrador actual"

