<script>
    import Header from "$lib/components/header/Header.svelte";
    import { fetchPost } from "$lib/utils/util-fetch.js";
    import { onMount } from "svelte";
    import Button from "$lib/components/button/Button.svelte";
    import Input from "$lib/components/input/Input.svelte";

    $: region = null;
    let formCaseificio;

    onMount(() => {
        const urlParams = new URLSearchParams(window.location.search);
        region =
            urlParams.get("region").charAt(0).toUpperCase() +
            urlParams.get("region").slice(1);
    });

    const handlerClickCaseificio = async () => {
        const elements = {
            regione: formCaseificio.querySelector(".input-regione"),
            indirizzio: formCaseificio.querySelector(".input-indirizzio"),
            nome: formCaseificio.querySelector(".input-nome"),
            codice: formCaseificio.querySelector(".input-codice"),
            accountNome: formCaseificio.querySelector(".input-account-nome"),
            accountCognome: formCaseificio.querySelector(
                ".input-account-cognome"
            ),
            email: formCaseificio.querySelector(".input-email"),
            psw: formCaseificio.querySelector(".input-psw"),
        };

        const fetchInput = {
            regione: elements.regione.value,
            indirizzio: elements.indirizzio.value,
            nome: elements.nome.value,
            codice: elements.codice.value,
            accountNome: elements.accountNome.value,
            accountCognome: elements.accountCognome.value,
            email: elements.email.value,
            psw: elements.psw.value,
        };

        let isValid = true;

        Object.values(fetchInput).forEach((vl) => {
            if (vl === "") isValid = false;
        });

        if (!isValid) return;

        const url = "http://localhost:8888/insert_caseificio.php";

        await fetchPost(url, fetchInput).then(async (fetchResponce) => {
            const { status, data } = fetchResponce;

            console.log(fetchResponce);

            if (status >= 400) return;

            const urlParams = new URLSearchParams(window.location.search);
            window.location.href = `/gestione/consorzio/caseifici/${urlParams.get(
                "region"
            )}`;
        });
    };
</script>

<Header />
<form class="container" bind:this={formCaseificio}>
    <div class="container container-extend">
        <div class="container">
            <div class="container-input">
                <h5 class="text">Regione:</h5>
                <Input
                    type="text"
                    className="input-regione"
                    value={region}
                    required="true"
                    readonly={true}
                />
            </div>
            <div class="container-input">
                <h5 class="text">Indirizzio:</h5>
                <Input
                    type="text"
                    className="input-indirizzio"
                    required="true"
                />
            </div>
            <div class="container-input">
                <h5 class="text">Nome:</h5>
                <Input type="text" className="input-nome" required="true" />
            </div>
            <div class="container-input">
                <h5 class="text">Codice:</h5>
                <Input
                    type="number"
                    className="input-codice"
                    placeholder="xxxx"
                    maxlength="4"
                    required="true"
                />
            </div>
        </div>
        <div class="container">
            <div class="container-input">
                <h5 class="text">Nome account:</h5>
                <Input
                    type="text"
                    className="input-account-nome"
                    required="true"
                />
            </div>
            <div class="container-input">
                <h5 class="text">Cognome account:</h5>
                <Input
                    type="text"
                    className="input-account-cognome"
                    required="true"
                />
            </div>
            <div class="container-input">
                <h5 class="text">Email:</h5>
                <Input type="email" className="input-email" required="true" />
            </div>
            <div class="container-input">
                <h5 class="text">Password:</h5>
                <Input type="password" className="input-psw" required="true" />
            </div>
        </div>
    </div>
    <div class="button">
        <Button
            type="submit"
            text="Aggiungi"
            style="width: 40vw"
            handlerClick={handlerClickCaseificio}
        />
    </div>
</form>

<style>
    form.container {
        height: 60vh;

        padding: 2rem 10vw;

        display: flex;
        align-items: center;
        justify-content: center;
        flex-direction: column;
        gap: 4rem;
    }

    div.container {
        display: flex;
        align-items: flex-start;
        flex-direction: column;
        gap: 1rem;
    }

    div.container-extend {
        flex-direction: row;
        gap: 5rem;
    }

    div.container-input {
        display: flex;
        align-items: flex-start;
        flex-direction: column;
        gap: 0.4rem;
    }

    div.button {
        margin-top: 2rem;
    }
</style>
