import { fetchPost } from "$lib/utils/util-fetch.js";

export const load = async ({ params }) => {
    const { code } = params;

    const links = [
        { title: "Abruzzo", href: "/gestione/consorzio/caseifici/abruzzo", active: code.includes('abruzzo') },
        { title: "Basilicata", href: "/gestione/consorzio/caseifici/basilicata", active: code.includes('basilicata') },
        { title: "Calabria", href: "/gestione/consorzio/caseifici/calabria", active: code.includes('calabria') },
        { title: "Campania", href: "/gestione/consorzio/caseifici/campania", active: code.includes('campania') },
        { title: "Emilia-Romagna", href: "/gestione/consorzio/caseifici/emilia-romagna", active: code.includes('emilia-romagna') },
        { title: "Friuli-Venezia Giulia", href: "/gestione/consorzio/caseifici/friuli-venezia-giulia", active: code.includes('friuli-venezia-giulia') },
        { title: "Lazio", href: "/gestione/consorzio/caseifici/lazio", active: code.includes('lazio') },
        { title: "Liguria", href: "/gestione/consorzio/caseifici/liguria", active: code.includes('liguria') },
        { title: "Lombardia", href: "/gestione/consorzio/caseifici/lombardia", active: code.includes('lombardia') },
        { title: "Marche", href: "/gestione/consorzio/caseifici/marche", active: code.includes('marche') },
        { title: "Molise", href: "/gestione/consorzio/caseifici/molise", active: code.includes('molise') },
        { title: "Piemonte", href: "/gestione/consorzio/caseifici/piemonte", active: code.includes('piemonte') },
        { title: "Puglia", href: "/gestione/consorzio/caseifici/puglia", active: code.includes('puglia') },
        { title: "Sardegna", href: "/gestione/consorzio/caseifici/sardegna", active: code.includes('sardegna') },
        { title: "Sicilia", href: "/gestione/consorzio/caseifici/sicilia", active: code.includes('sicilia') },
        { title: "Toscana", href: "/gestione/consorzio/caseifici/toscana", active: code.includes('toscana') },
        { title: "Trentino-Alto Adige", href: "/gestione/consorzio/caseifici/trentino-alto-adige", active: code.includes('trentino-alto-adige') },
        { title: "Umbria", href: "/gestione/consorzio/caseifici/umbria", active: code.includes('umbria') },
        { title: "Valle d'Aosta", href: "/gestione/consorzio/caseifici/valle-d-aosta", active: code.includes('valle-d-aosta') },
        { title: "Veneto", href: "/gestione/consorzio/caseifici/veneto", active: code.includes('veneto') }

    ];

    const caseificiSource = [];

    const url = "http://localhost:8888/select_caseifici.php";

    await fetchPost(url, {})
    
    .then((fetchResponce) => {
        const { status, data } = fetchResponce;

        if (status >= 400) return;

        data.forEach(el => {
            caseificiSource.push({ name: el.name_caseificio, code: el.code_caseificio, region: el.caseificio_region });
        });
    });

    const caseifici = caseificiSource.filter(Caseificio => code.includes(Caseificio.region.toLowerCase()));

    return { code, links, caseifici };
}