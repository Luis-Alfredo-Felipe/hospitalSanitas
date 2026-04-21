SELECT 
    a.id_atencion AS 'Ticket',
    CONCAT(p.nombres, ' ', p.apellidos) AS 'Paciente',
    pr.nivel AS 'Gravedad',
    a.fecha_ingreso AS 'Hora de Llegada',
    a.estado_atencion AS 'Estado'
FROM 
    atenciones a
JOIN 
    pacientes p ON a.id_paciente = p.id_paciente
JOIN 
    prioridades pr ON a.id_prioridad = pr.id_prioridad
WHERE 
    a.estado_atencion = 'ESPERA'
ORDER BY 
    pr.id_prioridad ASC,  /**** 1ra Regla: Los números más bajos (1-Rojo) van primero. ****/
    a.fecha_ingreso ASC;  /**** 2da Regla (Desempate): Si tienen la misma gravedad, pasa el que llegó antes. ****/