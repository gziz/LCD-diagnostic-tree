(deffunction pregunta-usuario (?pregunta $?opciones)
	(printout t crlf ?pregunta ?opciones "? ")
	(bind ?respuesta (read))
	
	(while (not (member$ ?respuesta ?opciones)) do
		(printout t crlf ?pregunta ?opciones "? ")
		(bind ?respuesta (read))
	)
	(return ?respuesta)
)

;1
(defrule inicio
	(initial fact)
=>
	(assert (liveBIOSscreen (pregunta-usuario "Live BIOS splash screen?" yes no)))
)

;2
(defrule no-live-BIOS-screen
	(liveBIOSscreen no)
=>
	(assert (liveExternalDisplay (pregunta-usuario "Live on external display?" yes no)))
)

;3
(defrule no-live-external-display
	(liveExternalDisplay no)
=>
	(assert (fanHarddriveSound (pregunta-usuario "Fan or hard drive sound?" yes no)))
)

;4
(defrule fan-harddrive-sound
	(fanHarddriveSound yes)
=>
	(printout t crlf "Confirm toggled to good external monitor. No display on either laptop screen or external monitor indicates board level failure" crlf crlf)
)

;5
(defrule no-fan-harddrive-sound
	(fanHarddriveSound no)
=>
	(printout t crlf "Proceed to Laptop Power Failure" crlf crlf)
)

;6
(defrule live-external-display
	(liveExternalDisplay yes)
=>
	(assert (dimDesktopImage (pregunta-usuario "Dim desktop image?" yes no)))
)

;7
(defrule dim-desktop-image
	(dimDesktopImage yes)
=>
	(assert (testInverterOK (pregunta-usuario "Test inverter OK?" yes no)))
)

;8
(defrule test-inverter-OK
	(testInverterOK yes)
=>
	(printout t crlf "Replace backlight (delicate job)" crlf crlf)
)

;9
(defrule no-test-inverter-OK
	(testInverterOK no)
=>
	(printout t crlf "Replace inverter when input live output dead)." crlf crlf)
)

;10
(defrule no-dim-desktop-image
	(dimDesktopImage no)
=>
	(assert (redoConnectionsFix (pregunta-usuario "Redo connections fix?" yes no)))
)

;11
(defrule no-redo-connections-fix
	(redoConnectionsFix no)
=>
	(printout t crlf "Inspect wires in hinge for physical failure. LCD, or board level connector failure." crlf crlf)
)

;12
(defrule redo-connections-fix
	(redoConnectionsFix yes)
=>
	(printout t crlf "Lucky!" crlf crlf)
)

;13
(defrule live-BIOS-screen
	(liveBIOSscreen yes)
=>
	(assert (liveDesktopsOS (pregunta-usuario "Live desktop in OS?" yes no)))
)

;14
(defrule no-live-desktop-OS
	(liveDesktopsOS no)
=>
	(assert (bootsWoDisplay (pregunta-usuario "Boots w/o display?" yes no)))
)

;15
(defrule no-boots-wo-display
	(bootsWoDisplay no)
=>
	(printout t crlf "Proceed to hard drive failure" crlf crlf)
)

;16
(defrule boots-wo-display
	(bootsWoDisplay yes)
=>
	(printout t crlf "Toggle failure or video driver, try safe mode." crlf crlf)
)

;17
(defrule live-desktop-OS
	(liveDesktopsOS yes)
=>
	(assert (thinLinesTinySpots (pregunta-usuario "Thin lines or tiny spots?" yes no)))
)

;18
(defrule thin-lines-tiny-spots
	(thinLinesTinySpots yes)
=>
	(printout t crlf "When tiny spots or screen length lines are always present, LCD is failing (or dirty)." crlf crlf)
)

;19
(defrule no-thin-lines-tiny-spots
	(thinLinesTinySpots no)
=>
	(assert (imageUpsideDownSideways (pregunta-usuario "Image upside-down sideways?" yes no)))
)

;20
(defrule image-upside-down-sideways
	(imageUpsideDownSideways yes)
=>
	(printout t crlf "CRTL-ALT plus up-arrow or side-arrow, or check video properties." crlf crlf)
)

;21
(defrule no-image-upside-down-sideways
	(imageUpsideDownSideways no)
=>
	(assert (RedOrangeTint (pregunta-usuario "Red, orange tint, uneven?" yes no)))
)

;22
(defrule red-orange-tint
	(RedOrangeTint yes)
=>
	(printout t crlf "Usually indicates the CCFL backlight is failing. A tough job on some laptops due to geometry." crlf crlf)
)

;23
(defrule no-red-orange-tint
	(RedOrangeTint no)
=>
	(assert (displayScrambles (pregunta-usuario "Display scrambles w/ time?" yes no)))
)

;24
(defrule display-scrambles
	(displayScrambles yes)
=>
	(printout t crlf "Classic video processor overheating or memory failure. Check heatsinks thermal compound." crlf crlf)
)

;25
(defrule display-scrambles
	(displayScrambles no)
=>
	(assert (stainGrowingPlume (pregunta-usuario "Stain or growing plume?" yes no)))
)

;26
(defrule stain-growing-plume
	(stainGrowingPlume yes)
=>
	(printout t crlf "LCD rupture, liquid crystal leak, replace LCD." crlf crlf)
)
;27
(defrule no-stain-growing-plume
	(stainGrowingPlume no)
=>
	(assert (totalBlackouts (pregunta-usuario "Total blackouts at random?" yes no)))
)

;28
(defrule no-total-blackouts
	(totalBlackouts no)
=>
	(printout t crlf "For large icons, blurry display, mouse trails, stuttering movement, check your video drive settings, try hardware acceleration, etc." crlf crlf)
)

;29
(defrule total-blackouts
	(totalBlackouts yes)
=>
	(printout t crlf "If entering hibernation, check lid switch. Going to sleep, check power saver settings, screensaver. Try toggling LCD/external monitor." crlf crlf)
)