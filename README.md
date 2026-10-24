# Controllo robusto H∞ di un convertitore Buck

Progetto di **controllo robusto H∞ e μ-analisi** per un convertitore DC-DC Buck, sviluppato in MATLAB. Il controllore è sintetizzato con `hinfsyn` e validato in termini di stabilità e prestazioni robuste rispetto a incertezze parametriche sui componenti del circuito.

> Corso di Robust Control · A.A. 2025/2026 · 
> Lavoro individuale

---

## Obiettivo

Progettare un controllore per un convertitore Buck che garantisca:

- **stabilità robusta** al variare dei parametri incerti (L, C, R_i, R_c, R_ON) e del carico R_L;
- **buone prestazioni** di regolazione e reiezione dei disturbi;
- **robustezza** verificata  con analisi strutturata (μ) 

Il modello di partenza è ispirato a un lavoro accademico di Lena, Setti, Pareschi et al.; il progetto ne riprende la formulazione e la estende con una versione modificata della funzione di trasferimento e con una seconda configurazione di sintesi.

## Contenuto

Il progetto copre l'intera pipeline di progettazione:

1. **Modellazione**: modulatore PWM, stadio di potenza (funzioni di trasferimento P11, P12, P21), anello di feedforward.
2. **Modellazione dell'incertezza**: famiglia incerta a 32 vertici (politopo) con `ureal`; incertezza non strutturata con `ucover` (ordine 6, struttura *input multiplicative*) e verifica del margine di copertura.
3. **Funzioni peso**: costruite sia con `makeweight` sia analiticamente, e messe a confronto.
4. **Pianta generalizzata**: costruita sia a mano sia con `connect`, con verifica dell'equivalenza numerica.
5. **Sintesi H∞** con `hinfsyn` e riduzione d'ordine del controllore.
6. **Analisi di robustezza**: `robstab`, `mussv`, `wcgain`; derivazione manuale del blocco **M11** della struttura M-Δ tramite LFT (5 blocchi reali scalari non ripetuti) e confronto con l'estrazione automatica via `lftdata`.
7. **Robust Performance**: nominal performance (NP), robust stability (RS) e robust performance (RP).

## Struttura del repository

```
buck-converter-hinf-control/
├── README.md
├── LICENSE
├── .gitignore
├── matlab/        ← script e Live Script (modello, pesi, sintesi, μ-analisi)
├── docs/          ← relazione completa in PDF 
```

## Come eseguirlo

**Requisiti**: MATLAB con

- Control System Toolbox
- Robust Control Toolbox

**Esecuzione**:

1. Clona il repository:
   ```bash
   git clone https://github.com/TUO-USERNAME/buck-converter-hinf-control.git
   ```
2. Apri MATLAB e imposta `matlab/` come cartella corrente.
3. Esegui il Live Script `buck_converter_modelk.mlx` sezione per sezione, nell'ordine in cui compaiono.

## Relazione

La relazione completa (modellazione, scelta dei pesi, sintesi, analisi di robustezza e discussione dei risultati) è disponibile in [`docs/`](docs/).

## Strumenti

`MATLAB` · `Control System Toolbox` · `Robust Control Toolbox` · `LaTeX`

## Riferimenti

- Lena, Setti, Pareschi et al., lavoro accademico sul controllo robusto del convertitore Buck *(completa con titolo, rivista e anno)*.

## Autore

**Raffaella** · Studentessa di Ingegneria
[LinkedIn](https://www.linkedin.com/in/Raffaella Moccia) · [Email](mailto:mocciaraff03@gmail.com)


