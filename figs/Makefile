.PHONY : copyfigs all

all : koopas.png koopas_dispersal.png koopas_mates.png koopas_density.png koopas_death.png  10kouts_coalescence_by_generation.png sumstat_by_dispersal_spat_v_rm.png sfs_spatial_continuous_bins.png

koopas.pdf : koopa_dynamics.ink.svg
	./export-layers-svg.sh $< base > $@

koopas_dispersal.pdf : koopa_dynamics.ink.svg
	./export-layers-svg.sh $< base kids dispersal > $@

koopas_mates.pdf : koopa_dynamics.ink.svg
	./export-layers-svg.sh $< base kids mate_choice > $@

koopas_density.pdf : koopa_dynamics.ink.svg
	./export-layers-svg.sh $< base kids density > $@

koopas_death.pdf : koopa_dynamics.ink.svg
	./export-layers-svg.sh $< base kids death > $@


copyfigs : 
	cp ../../../../projects/space/spaceness/viz/*/*.anim.mp4 .



## image conversion

%.pdf : %.svg
	inkscape $< --export-pdf=$@

# %.svg : %.pdf
# 	inkscape $< --export-plain-svg=$@

%.png : %.pdf
	convert -density 300 $< -flatten $@

%.gif : %.pdf
	convert -density 300 $< -flatten $@

%.png : %.svg
	convert -density 300 $< -flatten $@

%.gif : %.svg
	convert -density 300 $< -flatten $@

%.pdf : %.ink.svg
	inkscape $< --export-pdf=$@

# animated gif
%.anim.gif : $(wildcard %/*.gif)
	convert -loop 0 -delay 10 -coalesce -fuzz 2% -layers optimize $$(ls $*/*.gif) $@

