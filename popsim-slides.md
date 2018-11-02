---
title: "Space is the Place"
author: "Peter Ralph"
date: "PopSim // 4 November 2018 // CSHL"
---

# Geography

## Waldo Tobler's First Law

> Everything is related to everything else, but near things are more related than distant things.


## 

$$ \text{Wright-Fisher} + \text{geography} $$

. . .

$$ \qquad {} = \text{a pain in the torus} $$

. . .

*Felensestein, 1975*

## The pain

<center>
<video width="600" height="600" controls>
  <source src="figs/pain.500.anim.mp4" type="video/mp4">
</video>
</center>

## A related pain

**Coalescent theory** requires *random mating* in large populations,
because:

> 1. Lineages must move *independently* until the coalesce, and
> 2. if we know one offspring came from a certain location,
> 3. that location may be more likely to be the source of others.

. . .

::: {.columns}
::::::: {.column width="25%"}

![](figs/finger_right.png){width=90%}

:::
::::::: {.column width="75%"}

We need **forward simulation** for realistic geography.

:::
:::::::

## The promise

Geography could add a *lot* of information.

. . .

With $n$ samples and no geography, there are $n$ informative entries in the SFS.

. . .

With georeferenced data, each of the $n(n-1)/2$ different pairwise divergences
provide different information.

-------------

![](figs/torts/pwp_etort-191_shaded.png)

-------------

![](figs/torts/pwp_etort-229_shaded.png)

-------------

![](figs/torts/pwp_etort-240_shaded.png)

-------------

![](figs/torts/pwp_etort-253_shaded.png)

-------------

![](figs/torts/pwp_etort-273_shaded.png)

-------------

![](figs/torts/pwp_etort-27_shaded.png)

-------------

![](figs/torts/pwp_etort-283_shaded.png)

-------------

![](figs/torts/pwp_etort-285_shaded.png)

-------------

![](figs/torts/pwp_etort-35_shaded.png)

-------------

![](figs/torts/pwp_etort-57_shaded.png)

-------------

![](figs/torts/pwp_etort-71_shaded.png)

-------------

![](figs/torts/pwp_etort-78_shaded.png)


# Modeling

## 

<center>

The earth is not flat.

</center>

. . .

<center>

barriers, currents, microclimates ...

</center>


##

<center>

Population regulation is **local**.

</center>


. . .

<center>

That means the Wright-Fisher model is *right out*.

</center>


##  

::: {.columns}
::::::: {.column width="50%"}

1. **Dispersal:** 
    offspring live near their parents.

:::
::::::: {.column width="50%"}

![](figs/koopas.png){width=100%}

:::
:::::::


##  

::: {.columns}
::::::: {.column width="50%"}

1. **Dispersal:** 
    offspring live near their parents.

:::
::::::: {.column width="50%"}

![](figs/koopas_dispersal.png){width=100%}

:::
:::::::


##  

::: {.columns}
::::::: {.column width="50%"}

Given a *interaction kernel*, e.g.
$$
    \rho(r) = \frac{1}{2 \pi \sigma^2} e^{- r^2 / 2 \sigma^2} :
$$

2. **Mate choice:** 
    partner $j$ at distance $r_j$ chosen proportional to $\rho(r_j)$.

:::
::::::: {.column width="50%"}

![](figs/koopas_mates.png){width=100%}

:::
:::::::


##  

::: {.columns}
::::::: {.column width="50%"}

Given a *interaction kernel*, e.g.
$$
    \rho(r) = \frac{1}{2 \pi \sigma^2} e^{- r^2 / 2 \sigma^2} :
$$

3. **Population regulation:**
    with local density
    $$ D = \sum_j \rho(r_j) , $$
    *survival*, *fecundity*, and/or *establishment* decrease with $D$.

:::
::::::: {.column width="50%"}

![](figs/koopas_density.png){width=100%}

:::
:::::::


##  

::: {.columns}
::::::: {.column width="50%"}

Given a *interaction kernel*, e.g.
$$
    \rho(r) = \frac{1}{2 \pi \sigma^2} e^{- r^2 / 2 \sigma^2} :
$$

3. **Population regulation:**
    with local density
    $$ D = \sum_j \rho(r_j) , $$
    *survival*, *fecundity*, and/or *establishment* decrease with $D$.

:::
::::::: {.column width="50%"}

![](figs/koopas_death.png){width=100%}

:::
:::::::


## Computation

To do this, we need to know
$$ \rho(\|x_i - x_j\|) $$
for each pair of individuals.

. . .

<center>
*(cue dramatic music)*
</center>

. . .

This is...
$$ O(N^2) $$


## Computation

To do this, we need to know
$$ \rho(\|x_i - x_j\|) $$
for each pair of **nearby** individuals.

. . .

... say, for all pairs with $\|x_i - x_j\| \le R$.

. . .

A $k$-d tree

: allows finding all points within distance $R$ in $\log(N)$-time.

Computation time scales with $N M \log(N)$, where $M$ is the number of neighbors within distance $R$.


## Can I do this yet?

::: {.columns}
::::::: {.column width="50%"}


**Yes!!** 


In SLiM v3.1:

- nonWF modes
- spatial interactions
- geographic maps
- tree sequence recording


Next: heterogeneous dispersal?

:::
::::::: {.column width="50%"}

![](figs/slim_logo.png)

Haller & Messer 2018: SLiM v3.1

Haller, Galloway, kelleher, Messer & Ralph 2018 bioRxiv:407783 

:::
:::::::


# But does it matter?

## 

::: {.columns}
::::::: {.column width="50%"}

<center>

![](figs/cjb.jpg){width=80%}

CJ Battey

</center>

:::
::::::: {.column width="50%"}

<center>

![](figs/kern.jpg){width=80%}

Andy Kern

</center>

:::
:::::::


## Simulations

> 1. Flat, square habitat.
> 2. Neutral.
> 3. Mate choice: proportional to $e^{-d_{ij}^2 /2 \sigma_m^2}$.
> 4. Poisson(1/4) offspring each time step
> 5. ... which disperse a Normal$(0, \sigma_d)$ distance.
> 6. Local density for $i$ computed as:
>     $$ D_i = \sum_{j \neq i} e^{-d_{ij}^2 /2 \sigma_i^2} / 2 \pi \sigma_i^2, $$
> 7. Probability of survival:
>     $$ \min(0.95, 1/(1 + D_i / 5 K) . $$
> 8. $10^8$ bp with recomb rate $10^{-9}$; neutral mutations on the tree sequence after.

## $\sigma_d = \sigma_i = 2$

<center>
<video width="600" height="600" controls>
  <source src="figs/flat.500.anim.mp4" type="video/mp4">
</video>
</center>

## $\sigma_d = 0.15, $\sigma_i = 0.5$

<center>
<video width="600" height="600" controls>
  <source src="figs/metapops.500.anim.mp4" type="video/mp4">
</video>
</center>

## $\sigma_d = 0.25, $\sigma_i = 0.2$

<center>
<video width="600" height="600" controls>
  <source src="figs/patchy.500.anim.mp4" type="video/mp4">
</video>
</center>



## Nice pictures, but Does it *actually* matter?

- We varied *one* parameter, $\sigma_d = \sigma_i = \sigma_m$.

- Comparison: nonspatial mate choice.

- If well-mixed, mean density is $K=5$ individuals per unit square.

- Run times: XXX for XX diploids with $10^8$ bp,
    recombination rate $10^{-9}$, for 100K time steps.

## 

![](figs/10kouts_coalescence_by_generation.png)

##

![](figs/sumstat_by_dispersal_spat_v_rm.png)

##

![](figs/sfs_spatial_continuous_bins.png)

##

IBD plots


# Wrap-up

## 

> 1. Geography is interesting! We want to know about it!
> 
> 2. Also, geographic structure affects our data, maybe strongly.
> 
> 3. This is good! (a source of information)
> 
> 4. And also bad. (inference is more complicated)
> 
> 5. But!!  We can now simulate it!
> 
> 6. Another complication: changes with time.

## References

- Felsenstein, 1975, 
- Barton, Depaulis and Etheridge 2002, TPB
