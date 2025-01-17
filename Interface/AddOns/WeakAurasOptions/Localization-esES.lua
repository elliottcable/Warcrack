if not(GetLocale() == "esES") then
    return;
end

local L = WeakAuras.L

-- Options translation
L["1 Match"] = "1 Correspondencia"
L["Actions"] = "Acciones"
L["Activate when the given aura(s) |cFFFF0000can't|r be found"] = "Activar cuando el/las aura(s) |cFFFF0000no|r se encontraron"
L["Add a new display"] = "Añadir una nueva aura"
L["Add Dynamic Text"] = "Añadir Texto Dinámico"
L["Addon"] = "Addon"
L["Addons"] = "Addons"
L["Add to group %s"] = "Añadir al grupo %s"
L["Add to new Dynamic Group"] = "Añadir al nuevo Grupo Dinámico"
L["Add to new Group"] = "Añadir al nuevo Grupo"
L["Add Trigger"] = "Añadir Disparador"
L["A group that dynamically controls the positioning of its children"] = "Un grupo que dinámicamente controla la posición de sus hijos"
L["Align"] = "Alinear"
L["Allow Full Rotation"] = "Permitir Rotación Total"
L["Alpha"] = "Transparencia"
L["Anchor"] = "Anclaje"
L["Anchor Point"] = "Punto de Anclaje"
L["Angle"] = "Ángulo"
L["Animate"] = "Animar"
L["Animated Expand and Collapse"] = "Animar Pliegue y Despliegue"
L["Animation relative duration description"] = [=[Duración de la animación relativa a la duración del aura, expresado en fracciones (1/2), porcentaje (50%),  o decimales (0.5).
|cFFFF0000Nota:|r si el aura no tiene progreso (por ejemplo, si no tiene un activador basado en tiempo, si el aura no tiene duración, etc.), la animación no correrá.

|cFF4444FFPor Ejemplo:|r
Si la duración de la animación es |cFF00CC0010%|r, y el disparador del aura es un beneficio que dura 20 segundos, la animación de entrada se mostrará por 2 segundos.
Si la duración de la animación es |cFF00CC0010%|r, y el disparador del aura es un beneficio sin tiempo asignado, la animación de entrada se ignorará."
]=]
L["Animations"] = "Animaciones"
L["Animation Sequence"] = "Secuencia de Animación"
L["Aquatic"] = "Acuático"
L["Aura (Paladin)"] = "Aura"
L["Aura(s)"] = "Aura(s)"
L["Auto"] = "Auto"
L["Auto-cloning enabled"] = "Auto-clonado activado"
L["Automatic Icon"] = "Icono Automático"
L["Backdrop Color"] = "Color de fondo"
L["Backdrop Style"] = "Estilo de fondo"
L["Background"] = "Fondo"
L["Background Color"] = "Color de Fondo"
L["Background Inset"] = "Intercalado de Fondo"
L["Background Offset"] = "Desplazamiento del Fondo"
L["Background Texture"] = "Textura del Fondo"
L["Bar Alpha"] = "Transparencia de la Barra"
L["Bar Color"] = "Color de la Barra"
L["Bar Color Settings"] = "Configuración de color de barra"
L["Bar in Front"] = "Barra en primer plano"
L["Bar Texture"] = "Textura de la Barra"
L["Battle"] = "Combate"
L["Bear"] = "Oso"
L["Berserker"] = "Rabioso"
L["Blend Mode"] = "Modo de Mezcla"
L["Blood"] = "Sangre"
L["Border"] = "Borde"
L["Border Color"] = "Color de borde"
L["Border Inset"] = "Borde del recuadro"
L["Border Offset"] = "Desplazamiento de Borde"
L["Border Settings"] = "Configuración de bordes"
L["Border Size"] = "Tamaño del borde"
L["Border Style"] = "Estilo de borde"
L["Bottom Text"] = "Texto de Fondo"
L["Button Glow"] = "Resplandor del Botón"
L["Can be a name or a UID (e.g., party1). Only works on friendly players in your group."] = "Puede ser un nombre o un identificador de unidad(p.ej., party1). Solo funciona con personajes amistosos en tu grupo."
L["Cancel"] = "Cancelar"
L["Cat"] = "Gato"
L["Change the name of this display"] = "Cambiar el nombre del aura"
L["Channel Number"] = "Número de Canal"
L["Check On..."] = "Chequear..."
L["Choose"] = "Escoger"
L["Choose Trigger"] = "Escoger Disparador"
L["Choose whether the displayed icon is automatic or defined manually"] = "Escoge si quieres que el icono mostrado sea definido automáticamente o manualmente"
L["Clone option enabled dialog"] = "Activar diálogo de clonación"
L["Close"] = "Cerrar"
L["Collapse"] = "Plegar"
L["Collapse all loaded displays"] = "Plegar todas las auras"
L["Collapse all non-loaded displays"] = "Plegar todas las auras no cargadas"
L["Color"] = "Color"
L["Compress"] = "Comprimir"
L["Concentration"] = "Concentración"
L["Constant Factor"] = "Factor Constante"
L["Control-click to select multiple displays"] = "Control-clic para seleccionar múltiples auras"
L["Controls the positioning and configuration of multiple displays at the same time"] = "Controla la posición y configuración de varias auras a la vez"
L["Convert to..."] = "Convertir a..."
L["Cooldown"] = "Tiempo de Recarga"
L["Copy"] = "Copiar"
L["Copy settings from..."] = "Copiar configuraci'on desde..."
L["Copy settings from another display"] = "Copiar configuración de otra aura"
L["Copy settings from %s"] = "Copiar configuración de %s"
L["Count"] = "Contar"
L["Creating buttons: "] = "Crear pulsadores: "
L["Creating options: "] = "Crear opciones: "
L["Crop X"] = "Cortar X"
L["Crop Y"] = "Cortar Y"
L["Crusader"] = "Cruzado"
L["Custom Code"] = "Código Personalizado"
L["Custom Trigger"] = "Disparador Personalizado"
L["Custom trigger event tooltip"] = [=[
Escoje qué eventos quieres que chequeen el disparador personalizado.
Múltiples eventos pueden ser especificados, sepáralos con comas o espacios.

|cFF4444FFPor Ejemplo:|r
UNIT_POWER, UNIT_AURA PLAYER_TARGET_CHANGED
]=]
L["Custom trigger status tooltip"] = [=[
Escoje qué eventos quieres que chequeen el disparador personalizado.
Ya que éste es un Disparador del tipo Estado, los eventos especificados pueden ser invocados por WeakAuras sin ningún argumento.
Múltiples eventos pueden ser especificados, sepáralos con comas o espacios.

|cFF4444FFPor Ejemplo:|r
UNIT_POWER, UNIT_AURA PLAYER_TARGET_CHANGED
]=]
L["Custom Untrigger"] = "Disparador No-Personalizado"
L["Custom untrigger event tooltip"] = [=[
Escoje qué eventos quieres que chequeen el disparador personalizado.
Puede diferir de los eventos definidos por el disparador.
Múltiples eventos pueden ser especificados, sepáralos con comas o espacios.

|cFF4444FFPor Ejemplo:|r
UNIT_POWER, UNIT_AURA PLAYER_TARGET_CHANGED
]=]
L["Death"] = "Muerte"
L["Death Rune"] = "Runa Profana"
L["Debuff Type"] = "Tipo de Perjuicio"
L["Defensive"] = "Defensivo"
L["Delete"] = "Elimiar"
L["Delete all"] = "Eliminar todo"
L["Delete children and group"] = "Eliminar grupo (incluyendo hijos)"
L["Deletes this display - |cFF8080FFShift|r must be held down while clicking"] = "Eliminar aura - Pulsa |cFF8080FFShift|r a la vez (por seguridad)"
L["Delete Trigger"] = "Borrar Disparador"
L["Desaturate"] = "Desaturar"
L["Devotion"] = "Devoción"
L["Disabled"] = "Desactivado"
L["Discrete Rotation"] = "Rotación Discreta"
L["Display"] = "Mostrar"
L["Display Icon"] = "Mostrar Icono"
L["Display Text"] = "Mostrar Texto"
L["Distribute Horizontally"] = "Distribución Horizontal"
L["Distribute Vertically"] = "Distribución Vertical"
L["Do not copy any settings"] = "No copiar ninguna configuración"
L["Do not group this display"] = "No agrupar ésta aura"
L["Duplicate"] = "Duplicar"
L["Duration Info"] = "Información de Duración"
L["Duration (s)"] = "Duración (s)"
L["Dynamic Group"] = "Grupo Dinámico"
L["Dynamic text tooltip"] = "Descripción emergente dinámica"
L["Enabled"] = "Activado"
L["Enter an aura name, partial aura name, or spell id"] = "Introduce el nombre del aura (total o parcial), o el identificador del aura"
L["Event Type"] = "Tipo de Evento"
L["Expand"] = "Desplegar"
L["Expand all loaded displays"] = "Desplegar todas las auras"
L["Expand all non-loaded displays"] = "Desplegar todas las auras no cargadas"
L["Expand Text Editor"] = "Expandir el Editor de Texto"
L["Expansion is disabled because this group has no children"] = "No se puede expandir un grupo que no contenga hijos!"
L["Export"] = "Exportar"
L["Export to Lua table..."] = "Exportar a una tabla de LUA..."
L["Export to string..."] = "Exportar como texto cifrado..."
L["Fade"] = "Apagar"
L["Finish"] = "Finalizar"
L["Fire Resistance"] = "Resistencia al fuego"
L["Flight(Non-Feral)"] = "Volar(No-Feroz)"
L["Font"] = "Fuente"
L["Font Flags"] = "Fuente de banderas"
L["Font Size"] = "Tamaño de fuente"
L["Font Type"] = "Tipo de fuente"
L["Foreground Color"] = "Color Fontal"
L["Foreground Texture"] = "Textura Frontal"
L["Form (Druid)"] = "Forma"
L["Form (Priest)"] = "Forma"
L["Form (Shaman)"] = "Forma"
L["Form (Warlock)"] = "Forma"
L["Frame"] = "Macro"
L["Frame Strata"] = "Importancia del Marco"
L["Frost"] = "Escarcha"
L["Frost Resistance"] = "Resistencia al Frío"
L["Full Scan"] = "Escaneo Completo"
L["Ghost Wolf"] = "Lobo Fantasma"
L["Glow Action"] = "Acción de Destello"
L["Group aura count description"] = [=[La cantidad de %s miembros que deben ser afectados por el aura para que el activador se dispare.
Si el número introducido es un entero (p.ej. 5), lo interpretaré como el número absoluto de gente afectada el la banda.
Si el número introducido es una fracción (1/2), decimal (0.5), o un porcentaje (50%%), lo interpretaré como el porcentaje de jugadores afectados en la banda.

|cFF4444FFPor ejemplo:|r
|cFF00CC00> 0|r se activa cuando cualquier persona en la banda %s esté afectada
|cFF00CC00= 100%%|r se activa cuando todo el mundo en la banda %s esté afectado
|cFF00CC00!= 2|r se activa cuando el numero de personas %s afectadas no es 2
|cFF00CC00<= 0.8|r se activa cuando menos del 80%% de la banda %s está afectada (4 de 5 en grupos, 8 de 10 o 20 de 25 en bandas)
|cFF00CC00> 1/2|r se activa cuando más de la mitad de jugadores %s están afectados
|cFF00CC00>= 0|r siempre se activa
]=] -- Needs review
L["Group Member Count"] = "Contador del Miembro de Grupo"
L["Group (verb)"] = "Agrupar"
L["Height"] = "Alto"
L["Hide this group's children"] = "Esconder hijos"
L["Hide When Not In Group"] = "Esconder si no Estas Agrupado"
L["Horizontal Align"] = "Alineado Horizontal"
L["Icon Info"] = "Información del Icono"
L["Icon Inset"] = "Interior del Icono" -- Needs review
L["Ignored"] = "Ignorar"
L["Ignore GCD"] = "Ignorar el GCD"
L["%i Matches"] = "%i Correspondencias"
L["Import"] = "Importar"
L["Import a display from an encoded string"] = "Importar un aura desde un texto cifrado"
L["Justify"] = "Justificar"
L["Left Text"] = "Texto Izquierdo"
L["Load"] = "Cargar"
L["Loaded"] = "Cargado"
L["Main"] = "Principal"
L["Main Trigger"] = "Disparador Primario"
L["Mana (%)"] = "Mana (%)"
L["Manage displays defined by Addons"] = "Administra Auras definidas por Addons"
L["Message Prefix"] = "Prefijo del Mensaje"
L["Message Suffix"] = "Sufijo del Mensaje"
L["Metamorphosis"] = "Metamorfosis"
L["Mirror"] = "Reflejar"
L["Model"] = "Modelo"
L["Moonkin/Tree/Flight(Feral)"] = "Moonkin/Árbol/Volar(Feroz)"
L["Move Down"] = "Mover Abajo"
L["Move this display down in its group's order"] = "Mover abajo (dentro del grupo)"
L["Move this display up in its group's order"] = "Mover arriba (dentro del grupo)"
L["Move Up"] = "Mover Arriba"
L["Multiple Displays"] = "Múltiples auras"
L["Multiple Triggers"] = "Disparadores Múltiples"
L["Multiselect ignored tooltip"] = [=[
|cFFFF0000Ignorado|r - |cFF777777Único|r - |cFF777777Múltiple|r
Ésta opción no será usada al determinar cuándo se mostrará el aura]=]
L["Multiselect multiple tooltip"] = [=[
|cFF777777Ignorado|r - |cFF777777Único|r - |cFF00FF00Múltiple|r
Cualquier combinación de valores es posible.]=]
L["Multiselect single tooltip"] = [=[
|cFF777777Ignorado|r - |cFF00FF00Único|r - |cFF777777Múltiple|r
Sólo un valor coincidente puede ser escogido.]=]
L["Must be spelled correctly!"] = "Asegúrate de que lo escribiste bien!"
L["Name Info"] = "Información del Nombre"
L["Negator"] = "Negar"
L["New"] = "Nuevo"
L["Next"] = "Siguiente"
L["No"] = "no"
L["No Children"] = "Sin Hijos"
L["Not all children have the same value for this option"] = "No todos los hijos contienen la misma configuración."
L["Not Loaded"] = "No Cargado"
L["No tooltip text"] = "Sin Texto de Descripción"
L["% of Progress"] = "% de Progreso"
L["Okay"] = "Aceptar"
L["On Hide"] = "Ocultar"
L["Only match auras cast by people other than the player"] = "Solamente corresponder auras conjuradas por otros jugadores"
L["Only match auras cast by the player"] = "Solamente corresponder auras conjuradas por ti"
L["On Show"] = "Mostrar"
L["Operator"] = "Operador"
L["or"] = "o"
L["Orientation"] = "Orientación"
L["Other"] = "Otros"
L["Outline"] = "Contorno"
L["Own Only"] = "Solo Mías"
L["Player Character"] = "Caracter Jugador"
L["Play Sound"] = "Reproducir Sonido"
L["Presence (DK)"] = "Presencia"
L["Presence (Rogue)"] = "Sigilo"
L["Prevents duration information from decreasing when an aura refreshes. May cause problems if used with multiple auras with different durations."] = "Prevenir que el temporizador siga contando cuando el aura se refresca. Ten cuidado, pueden aparecer problemas si usas múltiples auras con múltiples duraciones."
L["Primary"] = "Primario"
L["Progress Bar"] = "Barra de Progreso"
L["Progress Texture"] = "Texture de Progreso"
L["Put this display in a group"] = "Poner aura dentro de un grupo"
L["Ready For Use"] = "Listo para Usar"
L["Re-center X"] = "Re-centrar X"
L["Re-center Y"] = "Re-centrar Y"
L["Remaining Time Precision"] = "Precisión del Tiempo Restante"
L["Remove this display from its group"] = "Sacar éste aura del grupo"
L["Rename"] = "Renombrar"
L["Requesting display information"] = "Pidiendo información del aura a %s..."
L["Required For Activation"] = "Necesario para Activación"
L["Retribution"] = "Retribución"
L["Right-click for more options"] = "Clic derecho para más opciones"
L["Right Text"] = "Texto Derecho"
L["Rotate"] = "Rotación"
L["Rotate In"] = "Rotar"
L["Rotate Out"] = "Rotar"
L["Rotate Text"] = "Rotar Texto"
L["Rotation"] = "Rotación"
L["Same"] = "Igual"
L["Search"] = "Buscar"
L["Secondary"] = "Secundario"
L["Select the auras you always want to be listed first"] = "Selecciona las auras que quieres que siempre sean listadas primero" -- Needs review
L["Send To"] = "Envar A"
L["Set tooltip description"] = "Personalizar definición"
L["Shadow Dance"] = "Danza de Sombras"
L["Shadowform"] = "Forma de Sombra"
L["Shadow Resistance"] = "Resistencia a Sombras"
L["Shift-click to create chat link"] = "Shift-clic para crear un |cFF8800FF[Link en el Chat]"
L["Show all matches (Auto-clone)"] = "Mostrar todas las coincidencias (Auto-clonar)"
L["Show players that are |cFFFF0000not affected"] = "Mostrar jugadores |cFFFF0000no afectados"
L["Shows a 3D model from the game files"] = "Muestra un modelo 3D directamente de los ficheros de WoW"
L["Shows a custom texture"] = "Muestra una textura"
L["Shows a progress bar with name, timer, and icon"] = "Muestra una barra de progreso con nombres, temporizadores, y icono"
L["Shows a spell icon with an optional a cooldown overlay"] = "Muestra un icono como aura con máscaras opcionales"
L["Shows a texture that changes based on duration"] = "Muestra una textura que cambia con el tiempo"
L["Shows one or more lines of text, which can include dynamic information such as progress or stacks"] = "Muestra una o varias lineas de texto, capaz de contener información cambiante como acumulaciones y/o progresos"
L["Shows the remaining or expended time for an aura or timed event"] = "Muestra el tiempo transcurrido o restante de un aura o evento."
L["Show this group's children"] = "Mostrar hijos"
L["Size"] = "Tamaño"
L["Slide"] = "Arrastrar"
L["Slide In"] = "Arrastrar Dentro"
L["Slide Out"] = "Arrastrar"
L["Sort"] = "Ordenar"
L["Sound"] = "Sonido"
L["Sound Channel"] = "Canal de Sonido"
L["Sound File Path"] = "Ruta al Fichero de Sonido"
L["Space"] = "Espacio"
L["Space Horizontally"] = "Espacio Horizontal"
L["Space Vertically"] = "Espacio Vertical"
L["Spell ID"] = "ID de Hechizo"
L["Spell ID dialog"] = "Diálogo de ID de Hechizo"
L["Stack Count"] = "Contar Acumulaciones"
L["Stack Count Position"] = "Posición del Contador de Acumulación"
L["Stack Info"] = "Información de Acumulaciones"
L["Stacks Settings"] = "Configuración de montones"
L["Stagger"] = "Tambaleo"
L["Stance (Warrior)"] = "Actitud"
L["Start"] = "Empezar"
L["Stealable"] = "Puede Robarse"
L["Stealthed"] = "En siglo"
L["Sticky Duration"] = "Duración Adhesiva"
L["Temporary Group"] = "Grupo Temporal"
L["Text"] = "Texto"
L["Text Color"] = "Color del Texto"
L["Text Position"] = "Posición del Texto"
L["Text Settings"] = "Configuración de textos"
L["Texture"] = "Textura"
L["Texture Info"] = "Información de Textura" -- Needs review
L["The children of this group have different display types, so their display options cannot be set as a group."] = "No todos los hijos contienen la misma configuración, así que no los puedes configurar bajo el mismo perfil."
L["The duration of the animation in seconds."] = "Duración de la animación (en segundos)."
L["The type of trigger"] = "Tipo de Activador"
L["This condition will not be tested"] = "Esta condición se ignorará."
L["This display is currently loaded"] = "Ésta aura está activa"
L["This display is not currently loaded"] = "Ésta aura NO está activa"
L["This display will only show when |cFF00FF00%s"] = "Ésta aura solo se mostrará cuando |cFF00FF00%s"
L["This display will only show when |cFFFF0000 Not %s"] = "Ésta aura solo se mostrará cuando |cFFFF0000 No %s"
L["This region of type \"%s\" has no configuration options."] = "Esta región de tipo \"%s\" no tiene opciones de configuración."
L["Time in"] = "Contar En"
L["Timer"] = "Tiempo"
L["Timer Settings"] = "Configuración de temporizadores"
L["Toggle the visibility of all loaded displays"] = "Alterar la visibilidad de todas las auras cargadas"
L["Toggle the visibility of all non-loaded displays"] = "Alterar la visibilidad de todas las auras no cargadas"
L["Toggle the visibility of this display"] = "Modifica la visibilidad del aura"
L["to group's"] = "al groupo"
L["Tooltip"] = "Descriptión emergente"
L["Tooltip on Mouseover"] = "Descripción Emergente al pasar el ratón"
L["Top Text"] = "Texto de Arriba"
L["to screen's"] = "a pantalla"
L["Total Time Precision"] = "Precisión del cronómetro"
L["Tracking"] = "Rastrear"
L["Travel"] = "Viaje"
L["Trigger"] = "Disparador"
L["Trigger %d"] = "Disparador %d"
L["Triggers"] = "Disparadores"
L["Type"] = "Tipo"
L["Ungroup"] = "Desagrupar"
L["Unholy"] = "Profano"
L["Unit Exists"] = "Unidad Existe"
L["Unlike the start or finish animations, the main animation will loop over and over until the display is hidden."] = "Ignorar animaciones de inicio y final: la animación principal se repetirá hasta que el aura se oculte."
L["Unstealthed"] = "Fuera de Sigilo"
L["Update Custom Text On..."] = "Actualizar Texto Personalizado En..."
L["Use Full Scan (High CPU)"] = "Escaneo Total (carga el procesador)"
L["Use tooltip \"size\" instead of stacks"] = "Usa \"tamaño\" en vez de acumulaciones"
L["Vertical Align"] = "Alineado Vertical"
L["View"] = "Ver"
L["Width"] = "Ancho"
L["X Offset"] = "X Posicion"
L["X Scale"] = "X Escala"
L["Yes"] = "Sí"
L["Y Offset"] = "Y Posicion"
L["Y Scale"] = "Y Escala"
L["Z Offset"] = "Desplazamiento en Z"
L["Zoom"] = "Ampliación"
L["Zoom In"] = "Acercar"
L["Zoom Out"] = "Alejar"



