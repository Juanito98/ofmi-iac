#!/usr/bin/python3
import argparse
import csv
import logging


from typing import TextIO

_mexico_state_ids = {
    "Ciudad de México": "CMX",
    "Aguascalientes": "AGU",
    "Baja California": "BCN",
    "Baja California Sur": "BCS",
    "Campeche": "CAM",
    "Chiapas": "CHP",
    "Chihuahua": "CHH",
    "Coahuila": "COA",
    "Colima": "COL",
    "Durango": "DUR",
    "Guanajuato": "GUA",
    "Guerrero": "GRO",
    "Hidalgo": "HID",
    "Jalisco": "JAL",
    "Michoacán": "MIC",
    "Morelos": "MOR",
    "México": "MEX",
    "Nayarit": "NAY",
    "Nuevo León": "NLE",
    "Oaxaca": "OAX",
    "Puebla": "PUE",
    "Querétaro": "QUE",
    "Quintana Roo": "ROO",
    "San Luis Potosí": "SLP",
    "Sinaloa": "SIN",
    "Sonora": "SON",
    "Tabasco": "TAB",
    "Tamaulipas": "TAM",
    "Tlaxcala": "TLA",
    "Veracruz": "VER",
    "Yucatán": "YUC",
    "Zacatecas": "ZAC",
}


def generateIdentityFile(file: TextIO, generate_extended_file: bool) -> None:
    """
    Generate the identity file from the given file.
    """
    if not file.name.endswith(".in"):
        logging.warning(
            "It is recommended to use a .in file instead.\n"
            + "REMEMBER NOT TO COMMIT PERSONAL DATA."
        )

    reader = csv.DictReader(file)
    rows = list(reader)

    username_generator = {}

    def to_identity(row):
        """
        Generate a unique username for the given row.
        """
        _NOMBRE_COMPLETO = "Nombre completo"
        _ESTADO = "Estado"
        expected_columns = [_NOMBRE_COMPLETO, _ESTADO]
        assert all(
            col in row for col in expected_columns
        ), f"Missing columns in the input file: {expected_columns}"
        state_id = _mexico_state_ids[row[_ESTADO]]

        if state_id not in username_generator:
            username_generator[state_id] = 0
        username_generator[state_id] += 1
        username = f"{state_id}{username_generator[state_id]}"

        return {
            "username": username,
            "name": row[_NOMBRE_COMPLETO],
            "country_id": "MX",
            "state_id": state_id,
            "gender": "decline",
            "school_name": "OFMI",
        }

    output_rows = list(map(to_identity, rows))
    assert len(output_rows) > 0, "No rows found in the input file."
    assert len(output_rows) == len(list(rows)), len(list(rows))

    # Remove extension and add .out.csv
    extended_file = file.name.rsplit(".", 1)[0] + ".generated.in"
    output_file = file.name.rsplit(".", 1)[0] + ".generated.csv"

    with open(output_file, "w") as csv_out:
        writer = csv.DictWriter(csv_out, fieldnames=output_rows[0].keys())
        writer.writeheader()
        writer.writerows(output_rows)

    if generate_extended_file:
        with open(extended_file, "w") as csv_out:
            writer = csv.DictWriter(
                csv_out,
                fieldnames=["username", "state_id"] + list(reader.fieldnames or []),
            )
            writer.writeheader()
            for row, output_row in zip(rows, output_rows):
                row["username"] = output_row["username"]
                row["state_id"] = output_row["state_id"]
                writer.writerow(row)


def _main() -> None:
    parser = argparse.ArgumentParser(description="Generate the identity file.")
    parser.add_argument(
        "-v",
        "--verbose",
        action="store_true",
        help="Enable verbose output.",
    )
    parser.add_argument(
        "-e",
        "--extended",
        action="store_true",
        help="Generate the extended file.",
    )
    parser.add_argument(
        "file",
        type=argparse.FileType("r"),
        help="File to read the identity inputs from.",
    )

    args = parser.parse_args()

    logging.basicConfig(
        format="%(asctime)s: %(message)s",
        level=logging.DEBUG if args.verbose else logging.INFO,
    )
    logging.getLogger("urllib3").setLevel(logging.CRITICAL)

    generateIdentityFile(args.file, args.extended)
    args.file.close()


if __name__ == "__main__":
    _main()
