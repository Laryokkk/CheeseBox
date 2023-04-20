<script>
    import Header from "$lib/components/header/Header.svelte";
    import { fetchPost } from "$lib/utils/util-fetch.js";
    import { onMount } from "svelte";

    export let data;

    $: listFoto = [];
    $: caseificioData = {};
    let gMap;

    const fetchInput = { code: data.code };
    const urlBase = "http://localhost:8888";

    fetchPost(
        `${urlBase}/select_assets_by_caseificio_code.php`,
        fetchInput
    ).then(async (fetchResponce) => {
        const { status, data } = fetchResponce;

        if (status >= 400) return;

        data.forEach((asset) => {
            listFoto.push({ src: asset.asset_src });
        });

        listFoto = [...listFoto];
    });

    fetchPost(`${urlBase}/select_caseificio_by_code.php`, fetchInput).then(
        async (fetchResponce) => {
            const { status, data } = fetchResponce;

            if (status >= 400) return;

            caseificioData = data;
        }
    );

    onMount(() => {
        const latitudine = 45.650075;
        const longitudine = 13.767766;
        const mapOptions = {
            center: new google.maps.LatLng(latitudine, longitudine),
            zoom: 16,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
        };
        const map = new google.maps.Map(gMap, mapOptions);
        new google.maps.Marker({
            position: new google.maps.LatLng(latitudine, longitudine),
            map: map,
        });
        fetchPost(`${urlBase}/select_caseifici.php`, {}).then(
            async (fetchResponce) => {
                const { status, data } = fetchResponce;

                if (status >= 400) return;

                const image =
                    "https://www.appalo.it/quinta/images/formaggio.png";

                data.forEach(({ lagn, logn, code_caseificio }) => {
                    const pLatLng = new google.maps.LatLng(lagn, logn);

                    const marker = new google.maps.Marker({
                        position: pLatLng,
                        map: map,
                        icon: image,
                        url: `/caseificio/${code_caseificio}`,
                    });

                    google.maps.event.addListener(marker, "click", () => {
                        window.location.href = marker.url;
                    });
                });
            }
        );
    });
</script>

<Header />
<section class="container">
    <div class="container">
        <h3 class="text text-accent title">
            {caseificioData.name_caseificio}
        </h3>
        <h5 class="text">
            Codice: <span class="text-accent"
                >{caseificioData.code_caseificio}</span
            >
        </h5>
        <h5 class="text">
            Indirizzo: <span class="text-accent"
                >{caseificioData.caseificio_region}, {caseificioData.caseificio_street}</span
            >
        </h5>
        <div class="gmap" bind:this={gMap} />
    </div>
    <div class="container">
        <div class="wrapper-photo">
            {#each listFoto as { src }}
                <img {src} alt="caseificio" />
            {/each}
        </div>
    </div>
</section>

<style>
    section.container {
        height: 60vh;

        margin-top: 10vh;
        padding: 2rem 10vw;

        display: flex;
        align-items: flex-start;
        flex-direction: row;
        gap: 10rem;
    }

    div.container {
        display: flex;
        align-items: flex-start;
        flex-direction: column;
        gap: 1rem;
    }

    .title {
        margin-bottom: 1rem;
    }

    div.wrapper-photo {
        display: flex;
        flex-wrap: wrap;
        gap: 3rem;
    }

    img {
        height: 20rem;

        border-radius: 2rem;
    }

    div.gmap {
        width: 30vw;
        height: 30vh;

        border-radius: 2rem;

        margin-top: 5rem;
    }
</style>
