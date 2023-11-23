# LeDIIR

Projekt „Elektronická lexikální databáze indoíránských jazyků. Pilotní modul perština“, který je realizován s podporou Technologické agentury ČR ([TAČR](https://www.tacr.cz)) pod reg. č. [TL03000369](https://www.isvavai.cz/cep?ss=detail&n=0&h=TL03000369).

The project "Electronic lexical database of Indo-Iranian languages. Pilot module Persian", which is implemented with the support of the Technology Agency of the Czech Republic ([TAČR](https://www.tacr.cz)) under reg. no. [TL03000369](https://www.isvavai.cz/cep?ss=detail&n=0&h=TL03000369).

Toto úložiště obsahuje informace o zdrojových kódech aplikací, které se podílejí na přípravě a prezentaci slovníkových dat lexikální databáze indoíránských jazyků prostřednictvím webové a mobilní aplikace.

## LeDIIR LIFT to TEI Lex-0 conversion

Ve složce [lift-to-tei](/lift-to-tei/) je zdrojový kód aplikace v jazyce [XProc 3.0](https://xproc.org/specifications.html), která transformuje data z formátu [LIFT](https://github.com/sillsdev/lift-standard) (Lexicon Interchange FormaT) do formátu [TEI Lex-0](https://bit.ly/tei-lex-0). Součástí úložiště jsou také kódy pro analýzu vstupních dat.

## LeDIIR Mobile Application

V samostatném repozitáři [lediir-mobile-app](https://github.com/daliboris/lediir-mobile-app/) je zdrojový kód s nastavením pro aplikaci [Dictionary App Builder](https://software.sil.org/dictionaryappbuilder/), která slouží ke generování slovníkových aplikací pro platformy Android a iOS.

## LeDIIR Web Application

V samostatném repozitáři [lediir-web-app](https://github.com/daliboris/lediir-web-app/) je zdrojový kód webové aplikace pro zpřístupnění digitálních slovníků.

## LeDIIR Web Data

V samostatném repozitáři [lediir-web-data](https://github.com/daliboris/lediir-web-data/) je zdrojový kód webové knihovny eXist-db pro uložení a indexaci  digitálních slovníků.

## LeDIIR Web Users

V samostatném repozitáři [lediir-web-users](https://github.com/daliboris/lediir-web-users/) je zdrojový kód webové knihovny eXist-db pro vytvoření uživatelů webové aplikace.

## Prerekvizity

Pro běh výše uvedených aplikací se využívají následující komponenty:

- Běhové prostředí Java 11, např.  Zulu Community OpenJDK (<https://www.azul.com/downloads/?package=jdk>) s licencí <https://www.azul.com/products/core/openjdk-terms-of-use/> (software chráněný autorskými právy, 100% open source, poskytován "TAK, JAK JE", bez jakýchkoli záruk).
- Nativní XML databáze eXist-db (<http://exist-db.org>) je distribuována pod licencí LGPL (<https://cs.wikipedia.org/wiki/GNU_Lesser_General_Public_License>), což znamená, že je volně šiřitelná a že ji mohou využívat i programy, které volně šiřitelné nejsou.
- Aplikace TEI Publisher (<https://teipublisher.com/index.html>) je distribuována pod licencí GPLv3 (<https://jxself.org/translations/gpl-3.cz.shtml>), což znamená, že zdrojový kód aplikace, která na jejím základě vznikne, musí být veřejně dostupný.
- Procesor MorganaXProc-III (<https://www.xml-project.com/morganaxproc-iii/>) je produkt s otevřeným kódem, který je distribuován pod licencí  GNU General Public License 3 (GPLv3; <https://jxself.org/translations/gpl-3.cz.shtml>).
- Aplikace SaxonJ-HE (<https://sourceforge.net/projects/saxon/files/Saxon-HE/10/>) využívá opensourcovou licenci Mozilla Public License (<https://www.mozilla.org/en-US/MPL/2.0/>).
- Ke generování mobilní aplikace slouží software společnosti SIL International Dictionary App Builder (<https://software.sil.org/dictionaryappbuilder/>) s licencí (<https://software.sil.org/dictionaryappbuilder/license/>), která opravňuje majitele slovníkových dat nebo pověřenou osobu bezplatně tento software používat a vytvářet s jeho pomocí mobilní aplikace.
- Písmo DejaVu Fonts (<https://dejavu-fonts.github.io>) s licencí (<https://dejavu-fonts.github.io/License.html>), která mj. umožňuje jeho bezplatnou distribuci v rámci jiného softwaru (např. mobilní aplikace).
- Písmo Kurinto (<https://kurinto.com>) s licencí SIL Open Font License Version 1.1 (<https://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=OFL>), která mj. umožňuje jeho bezplatnou distribuci v rámci jiného softwaru (např. mobilní aplikace).
