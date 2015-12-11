function [gde] = gd7(u,v)
	du = e^u+v*e^(u*v)+2*u-2*v-3;
	dv = 2*e^(2*v)+u*e^(u*v)+4*v-2*u-2;
	gde = [du dv];