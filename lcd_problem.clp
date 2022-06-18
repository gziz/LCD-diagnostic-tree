;;;
Equipo 6-
Gerardo Moreno Zizumbo A01734876
Sofía Ingigerth Cañas Urbina A01173828
Cristina López Ontiveros A01424566
Ricardo de Jesús Balam Ek A00831262
;;;

;;;
	RULES
;;;

;;; 
Se define la función pregunta-usuario, con parámetros la variable "pregunta" y la variable de varios 
elementos "opciones". Se lee la respuesta y mientras no esté en el conjunto se vuelve a preguntar por medio
de un ciclo while, cuando ya está en el conjunto se retorna la variable "respuesta".
;;;

(deffunction pregunta-usuario (?pregunta $?opciones)
	(printout t crlf ?pregunta ?opciones "? ")
	(bind ?respuesta (read))
	
	(while (not (member$ ?respuesta ?opciones)) do
		(printout t crlf ?pregunta ?opciones "? ")
		(bind ?respuesta (read))
	)
	(return ?respuesta)
)

;;;
	TEMPLATES
;;;

;1
;;; Se define la regla de inicio y se agrega el hecho de la pregunta en la posición 1, con posibles opciones
de respuesta "yes" o "no"
;;;
(defrule inicio
	(initial-fact)
=>
	(assert (liveBIOSscreen (pregunta-usuario "Live BIOS splash screen?" yes no)))
)

;2
;;; Se define la regla cuando la respuesta a la pregunta en la posición 1, es "no" y se agrega el hecho de la 
pregunta en la posición 2, con posibles opciones de respuesta "yes" o "no"
;;;
(defrule no-live-BIOS-screen
	(liveBIOSscreen no)
=>
	(assert (liveExternalDisplay (pregunta-usuario "Live on external display?" yes no)))
)

;3
;;; Se define la regla cuando la respuesta a la pregunta en la posición 2 es "no" y se agrega el hecho de la 
pregunta en la posición 3, con posibles opciones de respuesta "yes" o "no"
;;;
(defrule no-live-external-display
	(liveExternalDisplay no)
=>
	(assert (fanHarddriveSound (pregunta-usuario "Fan or hard drive sound?" yes no)))
)

;4
;;; Se define la regla cuando la respuesta a la pregunta en la posición 3 es "yes" y se despliega el string
localizado en la posición 4
;;;
(defrule fan-harddrive-sound
	(fanHarddriveSound yes)
=>
	(printout t crlf "Confirm toggled to good external monitor. No display on either laptop screen or external monitor indicates board level failure" crlf crlf)
)

;5
;;; Se define la regla cuando la respuesta a la pregunta en la posición 3 es "no" y se despliega el string
localizado en la posición 5
;;;
(defrule no-fan-harddrive-sound
	(fanHarddriveSound no)
=>
	(printout t crlf "Proceed to Laptop Power Failure" crlf crlf)
)

;6
;;; Se define la regla cuando la respuesta a la pregunta en la posición 2 es "yes" y se agrega el hecho de la 
pregunta en la posición 6, con posibles opciones de respuesta "yes" o "no"
;;;
(defrule live-external-display
	(liveExternalDisplay yes)
=>
	(assert (dimDesktopImage (pregunta-usuario "Dim desktop image?" yes no)))
)

;7
;;; Se define la regla cuando la respuesta a la pregunta en la posición 6 es "yes" y se agrega el hecho de la 
pregunta en la posición 7, con posibles opciones de respuesta "yes" o "no"
;;;
(defrule dim-desktop-image
	(dimDesktopImage yes)
=>
	(assert (testInverterOK (pregunta-usuario "Test inverter OK?" yes no)))
)

;8
;;; Se define la regla cuando la respuesta a la pregunta en la posición 7 es "yes" y se despliega el string
localizado en la posición 8
;;;
(defrule test-inverter-OK
	(testInverterOK yes)
=>
	(printout t crlf "Replace backlight (delicate job)" crlf crlf)
)

;9
;;; Se define la regla cuando la respuesta a la pregunta en la posición 7 es "no" y se despliega el string
localizado en la posición 9
;;;
(defrule no-test-inverter-OK
	(testInverterOK no)
=>
	(printout t crlf "Replace inverter when input live output dead)." crlf crlf)
)

;10
;;; Se define la regla cuando la respuesta a la pregunta en la posición 6 es "no" y se agrega el hecho de la 
pregunta en la posición 10, con posibles opciones de respuesta "yes" o "no"
;;;
(defrule no-dim-desktop-image
	(dimDesktopImage no)
=>
	(assert (redoConnectionsFix (pregunta-usuario "Redo connections fix?" yes no)))
)

;11
;;; Se define la regla cuando la respuesta a la pregunta en la posición 10 es "no" y se despliega el string
localizado en la posición 11
;;;
(defrule no-redo-connections-fix
	(redoConnectionsFix no)
=>
	(printout t crlf "Inspect wires in hinge for physical failure. LCD, or board level connector failure." crlf crlf)
)

;12
;;; Se define la regla cuando la respuesta a la pregunta en la posición 10 es "yes" y se despliega el string
localizado en la posición 12
;;;
(defrule redo-connections-fix
	(redoConnectionsFix yes)
=>
	(printout t crlf "Lucky!" crlf crlf)
)

;13
;;; Se define la regla cuando la respuesta a la pregunta en la posición 1 es "yes" y se agrega el hecho de la 
pregunta en la posición 13, con posibles opciones de respuesta "yes" o "no"
;;;
(defrule live-BIOS-screen
	(liveBIOSscreen yes)
=>
	(assert (liveDesktopsOS (pregunta-usuario "Live desktop in OS?" yes no)))
)

;14
;;; Se define la regla cuando la respuesta a la pregunta en la posición 13 es "no" y se agrega el hecho de la 
pregunta en la posición 14, con posibles opciones de respuesta "yes" o "no"
;;;
(defrule no-live-desktop-OS
	(liveDesktopsOS no)
=>
	(assert (bootsWoDisplay (pregunta-usuario "Boots w/o display?" yes no)))
)

;15
;;; Se define la regla cuando la respuesta a la pregunta en la posición 14 es "no" y se despliega el string
localizado en la posición 15
;;;
(defrule no-boots-wo-display
	(bootsWoDisplay no)
=>
	(printout t crlf "Proceed to hard drive failure" crlf crlf)
)

;16
;;; Se define la regla cuando la respuesta a la pregunta en la posición 14 es "yes" y se despliega el string
localizado en la posición 16
;;;
(defrule boots-wo-display
	(bootsWoDisplay yes)
=>
	(printout t crlf "Toggle failure or video driver, try safe mode." crlf crlf)
)

;17
;;; Se define la regla cuando la respuesta a la pregunta en la posición 13 es "yes" y se agrega el hecho de la 
pregunta en la posición 17, con posibles opciones de respuesta "yes" o "no"
;;;
(defrule live-desktop-OS
	(liveDesktopsOS yes)
=>
	(assert (thinLinesTinySpots (pregunta-usuario "Thin lines or tiny spots?" yes no)))
)

;18
;;; Se define la regla cuando la respuesta a la pregunta en la posición 17 es "yes" y se agrega el hecho de la 
pregunta en la posición 18, con posibles opciones de respuesta "yes" o "no"
;;;
(defrule thin-lines-tiny-spots
	(thinLinesTinySpots yes)
=>
	;(printout t crlf "When tiny spots or screen length lines are always present, LCD is failing (or dirty)." crlf crlf)
	(assert (screenCleanFix (pregunta-usuario "Has cleaning the screen removed the lines and dots?" yes no)))
)

;19
;;; Se define la regla cuando la respuesta a la pregunta en la posición 17 es "no" y se agrega el hecho de la 
pregunta en la posición 19, con posibles opciones de respuesta "yes" o "no"
;;;
(defrule no-thin-lines-tiny-spots
	(thinLinesTinySpots no)
=>
	(assert (imageUpsideDownSideways (pregunta-usuario "Image upside-down sideways?" yes no)))
)

;20
;;; Se define la regla cuando la respuesta a la pregunta en la posición 19 es "yes" y se despliega el string
localizado en la posición 20
;;;
(defrule image-upside-down-sideways
	(imageUpsideDownSideways yes)
=>
	(printout t crlf "CRTL-ALT plus up-arrow or side-arrow, or check video properties." crlf crlf)
)

;21
;;; Se define la regla cuando la respuesta a la pregunta en la posición 19 es "no" y se agrega el hecho de la 
pregunta en la posición 21, con posibles opciones de respuesta "yes" o "no"
;;;

(defrule no-image-upside-down-sideways
	(imageUpsideDownSideways no)
=>
	(assert (RedOrangeTint (pregunta-usuario "Red, orange tint, uneven?" yes no)))
)

;22
;;; Se define la regla cuando la respuesta a la pregunta en la posición 21 es "yes" y se despliega el string
localizado en la posición 22
;;;
(defrule red-orange-tint
	(RedOrangeTint yes)
=>
	(printout t crlf "Usually indicates the CCFL backlight is failing. A tough job on some laptops due to geometry." crlf crlf)
)

;23
;;; Se define la regla cuando la respuesta a la pregunta en la posición 21 es "no" y se agrega el hecho de la 
pregunta en la posición 23, con posibles opciones de respuesta "yes" o "no"
;;;
(defrule no-red-orange-tint
	(RedOrangeTint no)
=>
	(assert (displayScrambles (pregunta-usuario "Display scrambles w/ time?" yes no)))
)

;24
;;; Se define la regla cuando la respuesta a la pregunta en la posición 23 es "yes" y se despliega el string
localizado en la posición 24
;;;
(defrule display-scrambles
	(displayScrambles yes)
=>
	(printout t crlf "Classic video processor overheating or memory failure. Check heatsinks thermal compound." crlf crlf)
)

;25
;;; Se define la regla cuando la respuesta a la pregunta en la posición 23 es "no" y se agrega el hecho de la 
pregunta en la posición 25, con posibles opciones de respuesta "yes" o "no"
;;;
(defrule display-scrambles
	(displayScrambles no)
=>
	(assert (stainGrowingPlume (pregunta-usuario "Stain or growing plume?" yes no)))
)

;26
;;; Se define la regla cuando la respuesta a la pregunta en la posición 25 es "yes" y se agrega el hecho de la 
pregunta en la posición 26, con posibles opciones de respuesta "yes" o "no"
;;;
(defrule stain-growing-plume
	(stainGrowingPlume yes)
=>
	(assert (stainsOnTheEdges (pregunta-usuario "Stains appear mainly on the edges of the screen?" yes no)))
)

;27
;;; Se define la regla cuando la respuesta a la pregunta en la posición 25 es "no" y se agrega el hecho de la 
pregunta en la posición 27, con posibles opciones de respuesta "yes" o "no"
;;;
(defrule no-stain-growing-plume
	(stainGrowingPlume no)
=>
	(assert (totalBlackouts (pregunta-usuario "Total blackouts at random?" yes no)))
)

;28
;;; Se define la regla cuando la respuesta a la pregunta en la posición 27 es "no" y se despliega el string
localizado en la posición 28
;;;
(defrule no-total-blackouts
	(totalBlackouts no)
=>
	(printout t crlf "For large icons, blurry display, mouse trails, stuttering movement, check your video drive settings, try hardware acceleration, etc." crlf crlf)
)

;29
;;; Se define la regla cuando la respuesta a la pregunta en la posición 27 es "yes" y se despliega el string
localizado en la posición 29
;;;
(defrule total-blackouts
	(totalBlackouts yes)
=>
	(printout t crlf "If entering hibernation, check lid switch. Going to sleep, check power saver settings, screensaver. Try toggling LCD/external monitor." crlf crlf)
)

; Añadidas por el equipo

;30
;;; Se define la regla cuando la respuesta a la pregunta en la posición 18 es "yes" y se despliega el string
localizado en la posición 30
;;;
(defrule screen-clean-fix
	(screenCleanFix yes)
=>
	(printout t crlf "Lucky!" crlf crlf)
)

;31
;;; Se define la regla cuando la respuesta a la pregunta en la posición 18 es "no" y se agrega el hecho de la 
pregunta en la posición 31, con posibles opciones de respuesta "yes" o "no"
;;;
(defrule no-screen-clean-fix
	(screenCleanFix no)
=>
	(assert (annoyanceHigh (pregunta-usuario "Is the annoyance caused by the lines and dots worth buying a new LCD?" yes no)))
)

;32
;;; Se define la regla cuando la respuesta a la pregunta en la posición 31 es "no" y se despliega el string
localizado en la posición 32
;;;
(defrule no-annoyance-high
	(annoyanceHigh no)
=>
	(printout t crlf "A thin vertical line on the screen is almost certainly either a failed column driver, or a broken connection between the column driver and the pixel array.")
	(printout t crlf "Either way, it's unlikely to get worse, but it definitely won't get better by itself, either." crlf crlf)
)

;33
;;; Se define la regla cuando la respuesta a la pregunta en la posición 31 es "yes" y se despliega el string
localizado en la posición 33
;;;
(defrule annoyance-high
	(annoyanceHigh yes)
=>
	(printout t crlf "Replace LCD" crlf crlf)
)

;34
;;; Se define la regla cuando la respuesta a la pregunta en la posición 26 es "yes" y se despliega el string
localizado en la posición 34
;;;
(defrule stains-on-the-edges
	(stainsOnTheEdges yes)
=>
	(printout t crlf "The cause is seal damage due to possible contact with acid-base liquids. LCD is broken and there is a liquid crystal leak. Replace LCD" crlf crlf)
)

;35
;;; Se define la regla cuando la respuesta a la pregunta en la posición 26 es "no" y se despliega el string
localizado en la posición 35
;;;
(defrule stains-on-the-edges
	(stainsOnTheEdges no)
=>
	(printout t crlf "Stains concentrated in the middle of the screen are usually accompanied by cracks and indicate external physical damage, LCD rupture and liquid crystal leak. Replace LCD" crlf crlf)
)
