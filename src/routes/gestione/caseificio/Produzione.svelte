<script>
    import HeaderSection from "../HeaderSection.svelte";
    import Check from "$lib/components/check/Check.svelte";
    import Input from "$lib/components/input/Input.svelte";
    import Button from "$lib/components/button/Button.svelte";
    import { onMount } from "svelte";
    import { fetchPost } from "$lib/utils/util-fetch.js";
    import { getCookie } from "$lib/utils/util-cookie.js";

    let caseificioCode = null;
    let formMilk, formForma;
    $: isMilkButtonDisabled = true;
    $: isFormaButtonDisabled = true;
    $: checkValue = "";

    const getMonth = () => {
        const d = new Date(),
            m = d.getMonth() + 1,
            xdate = m < 10 ? "0" + m : m;

        return xdate;
    };

    const getYear = () => {
        return new Date().getFullYear();
    };

    const codeForma = {
        mounth: getMonth(),
        year: getYear(),
    };

    onMount(async () => {
        let fetchInput = { uuid: getCookie("id_user") };
        let url = "http://localhost:8888/select_user_by_uuid.php";

        await fetchPost(url, fetchInput).then(async (fetchResponce) => {
            const { status, data } = fetchResponce;

            if (status >= 400) return;

            const { user_permission } = data;
            caseificioCode = user_permission.split("_")[1];
        });
    });

    const handlerClickMilk = async () => {
        const listMilk = formMilk.querySelectorAll("input");

        let fetchInput = {
            code: caseificioCode,
            quantity: listMilk[0].value,
            type: "racolto",
        };
        let url = "http://localhost:8888/insert_milk.php";

        await fetchPost(url, fetchInput).then(async (fetchResponce) => {
            const { status, data } = fetchResponce;

            if (status >= 400) return;

            data.forEach((rec) => {
                checkValue += `LATE INSERITO RACOLTO ---> Quantita: ${rec.milk_quantity} \n`;
            });

            setTimeout(() => {
                checkValue = "";
            }, 6000);

            isMilkButtonDisabled = true;
        });

        fetchInput = {
            code: caseificioCode,
            quantity: listMilk[1].value,
            type: "lavorato",
        };
        url = "http://localhost:8888/insert_milk.php";

        await fetchPost(url, fetchInput).then(async (fetchResponce) => {
            const { status, data } = fetchResponce;

            if (status >= 400) return;

            data.forEach((rec) => {
                checkValue += `LATE INSERITO LAVORATO ---> Quantita: ${rec.milk_quantity} \n`;
            });

            setTimeout(() => {
                checkValue = "";
            }, 6000);

            isMilkButtonDisabled = true;
        });
    };

    const handlerClickForma = async () => {
        const elements = {
            stagionatura: formForma.querySelector(".input-stagionatura"),
            quantita: formForma.querySelector(".input-quantita"),
            scelta: formForma.querySelector(".input-scelta"),
        };

        const fetchInput = {
            code: caseificioCode,
            quantity: elements.quantita.value,
            stagionatura: elements.stagionatura.value,
            scelta: elements.scelta.value,
        };

        const url = "http://localhost:8888/insert_forma.php";

        await fetchPost(url, fetchInput).then(async (fetchResponce) => {
            const { status, data } = fetchResponce;

            if (status >= 400) return;

            data.forEach((rec) => {
                checkValue += `NUOVA FORMA INSERITA ---> Codice: ${rec.forma_code} / Stagionatura: ${rec.forma_stagionatura} / Scelta: ${rec.forma_scelta} \n`;
            });

            setTimeout(() => {
                checkValue = "";
            }, 6000);
        });
    };

    const parentHandlerMilkInput = (value) => {
        isMilkButtonDisabled = value === "";
    };

    const parentHandlerFormaInput = (value) => {
        isFormaButtonDisabled = value === "";
    };
</script>

<section class="container">
    <HeaderSection />
    <div class="container">
        <div class="wrapper">
            <h3 class="text text-accent">Latte</h3>
            <form name="form-latte" bind:this={formMilk}>
                <div class="container-input">
                    <h5 class="text">Racolto:</h5>
                    <Input
                        type="number"
                        parentHandlerInput={parentHandlerMilkInput}
                    />
                </div>
                <div class="container-input">
                    <h5 class="text">Lavorato:</h5>
                    <Input
                        type="number"
                        parentHandlerInput={parentHandlerMilkInput}
                    />
                </div>
                <Button
                    text="Salva"
                    disabled={isMilkButtonDisabled}
                    handlerClick={handlerClickMilk}
                />
            </form>
        </div>
        <div class="wrapper">
            <h3 class="text text-accent">Forme</h3>
            <form name="form-forme" bind:this={formForma}>
                <div class="internal-wrapper">
                    <div class="container-wrapper">
                        <div class="container-input">
                            <h5 class="text">Codice forma:</h5>
                            <Input
                                type="text"
                                className="input-code"
                                value={`${caseificioCode}-${codeForma.year}-${codeForma.mounth}-xxxx`}
                                required="true"
                                readonly={true}
                            />
                        </div>
                        <div class="container-input">
                            <h5 class="text">Stagionatura:</h5>
                            <Input
                                type="select"
                                className="input-stagionatura"
                                options={["20", "24", "30", "36"]}
                                required="true"
                                parentHandlerInput={parentHandlerFormaInput}
                            />
                        </div>
                    </div>
                    <div class="container-wrapper">
                        <div class="container-input">
                            <h5 class="text">Quantita:</h5>
                            <Input
                                type="number"
                                className="input-quantita"
                                required="true"
                                parentHandlerInput={parentHandlerFormaInput}
                            />
                        </div>
                        <div class="container-input">
                            <h5 class="text">Scelta:</h5>
                            <Input
                                type="select"
                                className="input-scelta"
                                options={["Prima", "Seconda"]}
                                required="true"
                                parentHandlerInput={parentHandlerFormaInput}
                            />
                        </div>
                    </div>
                </div>
                <Button
                    text="Salva"
                    disabled={isFormaButtonDisabled}
                    handlerClick={handlerClickForma}
                />
            </form>
        </div>
    </div>
    <Check value={checkValue} />
</section>

<style>
    section.container {
        height: 90%;

        padding: 2rem 4vw;

        display: flex;
        justify-content: flex-start;
        flex-direction: column;
        gap: 6rem;
    }

    div.container {
        display: flex;
        justify-content: space-between;
        flex-direction: row;
        gap: 6rem;
    }

    div.wrapper {
        display: flex;
        flex-direction: column;
        gap: 3rem;
    }

    form,
    div.container-wrapper {
        display: flex;
        gap: 1rem;
        flex-direction: column;
    }

    div.internal-wrapper {
        display: flex;
        flex-direction: row;
        gap: 4rem;
    }

    div.container-input {
        display: flex;
        align-items: flex-start;
        flex-direction: column;
        gap: 0.2rem;
    }
</style>
