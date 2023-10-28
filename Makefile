FORMS=\
 dynmenuf1.42f\
 dynmenuf2.42f\
 dynmenuf3.42f\
 dynmenuf90.42f

PROGMOD=\
 dynmenu.42m

all: $(PROGMOD) $(FORMS)

%.42f: %.per
	fglform -M $<

%.42m: %.4gl
	fglcomp -Wall -Wno-stdsql -M $<

run:: all
	FGLIMAGEPATH=$(FGLDIR)/lib/image2font.txt:$(PWD)/images fglrun dynmenu.42m

clean::
	rm -f *.42?
