# LeDIIR LIFT to TEI Lex-0 conversion

Projekt „Elektronická lexikální databáze indoíránských jazyků. Pilotní modul perština“, který je realizován s podporou Technologické agentury ČR ([TAČR](https://www.tacr.cz)) pod reg. č. [TL03000369](https://www.isvavai.cz/cep?ss=detail&n=0&h=TL03000369).

The project "Electronic lexical database of Indo-Iranian languages. Pilot module Persian", which is implemented with the support of the Technology Agency of the Czech Republic ([TAČR](https://www.tacr.cz)) under reg. no. [TL03000369](https://www.isvavai.cz/cep?ss=detail&n=0&h=TL03000369).

## Prerekvizity

Pro správné fungování konverze a informačních skriptů je potřeba mít nainstalovaný následující software:

- Běhové prostředí Java 11, např.  Zulu Community OpenJDK (<https://www.azul.com/downloads/?package=jdk>) s licencí <https://www.azul.com/products/core/openjdk-terms-of-use/>
- Procesor MorganaXProc-III (<https://www.xml-project.com/morganaxproc-iii/>) je produkt s otevřeným kódem, který je distribuován pod licencí GNU General Public License 3 (GPLv3; <https://jxself.org/translations/gpl-3.cz.shtml>).
- Aplikace SaxonJ-HE (<https://sourceforge.net/projects/saxon/files/Saxon-HE/10/>), která využívá opensourcovou licenci Mozilla Public License (<https://www.mozilla.org/en-US/MPL/2.0/>).

Programy XProc 3.0 lze spouštět z příkazového řádku nebo s pomocí jiných aplikací, např. [ANT](https://ant.apache.org) nebo [oXygen XML Editor](https://www.oxygenxml.com/xml_editor/download_oxygenxml_editor.html) (či jiné edice).

### Instalace procesoru MorganaXProc-III (na PC s Windows)

- nejprve si stáhněte podporovanou verzi programu **SaxonJ-HE** z úložiště <https://sourceforge.net/projects/saxon/files/Saxon-HE/>, např. [10.8](https://sourceforge.net/projects/saxon/files/Saxon-HE/10/Java/SaxonHE10-8J.zip/download)
  - rozzipujte stažený soubor do složky na svém počítači, např. do složky `D:\Programy\Saxon\HE\10`
- stáhněte program **MorganaXProc-III** z úložiště <https://sourceforge.net/projects/morganaxproc-iiise/files/>, např. verzi [1.0.4](https://sourceforge.net/projects/morganaxproc-iiise/files/MorganaXProc-IIIse-1.0.4/MorganaXProc-IIIse-1.0.4.zip/download)
  - rozzipujte stažený soubor do složky na svém počítači, např. tak, aby všechny soubory byly ve složce `D:\Programy\Xml\Morgana`
  - do podsložky `MorganaXProc-IIIse_lib` zkopírujte soubory `saxon-he-10.8.jar` a `saxon-he-xqj-10.8.jar`, které najdete ve složce s programem `SaxonJ-HE` (viz výše; tj. např. ve složce `D:\Programy\Saxon\HE\10`)
  - složku, která obsahuje mj. soubor `Morgana.bat`, a podsložku `MorganaXProc-IIIse_lib` přidejte do proměnné `PATH` prostředí Windows
    - např. z příkazové řádky (**CMD**; je potřeba spustit ji jako administrátor) příkazem `setx`: `setx Path=%Path%;D:\Programy\Xml\Morgana;D:\Programy\Xml\Morgana\MorganaXProc-IIIse_lib`
      - viz např. [zde](https://cz.moyens.net/windows/co-je-windows-path-a-jak-jej-pridavate-a-upravujete/) a [zde](https://gist.github.com/vhenzl/c876d335c456a33098f2)
- správnost instalace ověříte spuštěním příkazu `Morgana` z příkazové řádky; měl by se objevit přibližně tento výpis
![Výstp programu MorganaXProc-III](help/MorganaXProc-III-CMD-Output-window.png)

### Nápověda k programu MorganaXProc-III

Základní nápověda k ovládání procesoru je dostupná na adrese <https://www.xml-project.com/files/doc/manual.html>.

## Struktura a obsah složek v aktuálním úložišti

| Složka | Obsah |
| ------ | ----- |
| Dictionary | Složka pro výstup transformací do formátu TEI Lex-0 a dat pro mobilní aplikaci |
| Help | Složka pro pomocné soubor k této nápovědě |
| XProc | Složka s procedurami pro spouštění transformací a manipulaci se vstupními nebo vygenerovanými soubory |
| XQuery | Procedury v jazyce [XQuery](https://www.w3.org/TR/xquery-31/), které slouží zejména pro testování funkcí databáze a analýzu vstupních nebo výstupních dokumentů  |
| Xslt | Šablony pro transformaci vstupních a generovaných dokumentů XML, popř. pro formátování analýz dokumentů |
| XSpec | Testovací sady pro vybrané funkce |

## Konverze dokumentu z formátu LIFT do formátu TEI Lex-0

Transformace se spouští ve složce `XProc` z příkazové řádky příkazem `morgana .\LIFT-to-TEI.xpl -statics=.\defs.xml`.

Data ve formátu [LIFT](https://github.com/sillsdev/lift-standard) jsou tvořena dvěma soubory, obvykle s příponou `.lift` a `.lift-ranges`. Data ve formátu LIFT se generují z programu [FieldWorks Language Explorer](https://software.sil.org/fieldworks/). Oba soubory musejí být umístěny ve stejné složce.

Pro konverzi do formátu TEI Lex-0 slouží soubor `LIFT-to-TEI.xpl` a nastavení v souboru `defs.xml`.

V souboru `defs.xml` se nastavují pomocí údajů v atributu `@value` následující parametry (identifikované údajem v atributu `@name`):

- `create-sample`: ze vstupních dat použije všechna validní (hodnota `true`), nebo vybere pouze jejich poměrnou část (hodnota `false`; hodí se pro testování transformace nebo dat v aplikaci), např.

```xml
 <mox:option name="create-sample" value="false" />
```


- `root-directory`: cesta ke složce, v níž jsou umístěny dokumenty LIFT; cesta by měla být relativní k souboru `defs.xml` a může vést mimo úložiště zdrojových kódů, např.

```xml
<mox:option name="root-directory" value="'../../lediir-data/2022-11-05'" />
```

- `file-name`: název souboru, který se vygeneruje (obvykle stejný jako název hlavní složky), např.

```xml
<mox:option name="file-name" value="'2022-11-05'" />
```

- `source-lang`: dvojpísmenná zkratka výchozího jazyka slovníku podle standardu [ISO 639-1](https://cs.wikipedia.org/wiki/Seznam_k%C3%B3d%C5%AF_ISO_639-1), tj. malými písmeny, např.

```xml
 <mox:option name="source-lang" value="fa" />
```

Vygenerovaný soubor XML ve formátu TEI Lex-0 se uloží jednak do původní složky s daty ve formátu LIFT, tj. do složky `root-directory`, a to pod názvem ve formátu `LeDIIR-{sl}CS.xml`, kde se `{sl}` nahradí označením jazyka (parametrem `source-lang`) velkými písmeny, tj. např. `LeDIIR-FACS.xml` v případě perštiny.

Vygenerovaný soubor se pod stejným názvem uloží zároveň do složky `Dictionary`, která je na stejné úrovni jako složka `XProc`, a může tedy být součástí verzovaného úložiště. Pokud složka `Dictionary` neexistuje, sama se vytvoří.

## Modifikace dokumentu ve formátu LIFT pro mobilní aplikace

Transformace se spouští ve složce `XProc` z příkazové řádky příkazem `morgana .\LIFT-to-LIFT-Mobile.xpl -statics=.\defs.xml`.

Parametry v souboru `defs.xml` jsou identické jako u [konverze do formátu TEI Lex-0](#konverze-dokumentu-z-formátu-lift-do-formátu-tei-lex-0).

Data ve formátu [LIFT](https://github.com/sillsdev/lift-standard) jsou tvořena dvěma soubory, obvykle s příponou `.lift` a `.lift-ranges`. Data ve formátu LIFT se generují z programu [FieldWorks Language Explorer](https://software.sil.org/fieldworks/). Oba soubory musejí být umístěny ve stejné složce.

Data pro mobilní aplikace je potřeba upravit, jednak aby obsahovala pokud možno identická data jako aplikace webová, jednak aby obsahovala údaje, které aktuální verze Dictionary App Builderu neumí zobrazit. Ve druhém případě se jedná zejména o sémantické okruhy.

Vygenerovaný soubor ve formátu LIFT pod názvem ve formátu `LeDIIR-{sl}CS-mobile.xml`, kde se `{sl}` nahradí označením jazyka (parametrem `source-lang`) velkými písmeny, tj. např. `LeDIIR-FACS-mobile.lift` v případě perštiny, se uloží do složky `Dictionary`, která je na stejné úrovni jako složka `XProc`, a může tedy být součástí verzovaného úložiště. Pokud složka `Dictionary` neexistuje, sama se vytvoří.
