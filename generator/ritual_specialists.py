import xml.etree.ElementTree as ET
from xml.dom import minidom

a = ET.Element('a')

SPECIALISTS = ["SPECIALIST_WRITER", "SPECIALIST_ARTIST", "SPECIALIST_MUSICIAN",
               "SPECIALIST_SCIENTIST", "SPECIALIST_MERCHANT", "SPECIALIST_ENGINEER", "SPECIALIST_CIVIL_SERVANT"]
ORDINALS = ["First", "Second", "Third", "Fourth", "Fifth",
            "Sixth", "Seventh", "Eighth", "Nineth", "Tenth"]
SPECIALIST_TO_RITUAL_NAME = {"SPECIALIST_WRITER": "Eloquence", "SPECIALIST_ARTIST": "Finesse", "SPECIALIST_MUSICIAN": "Virtuosity",
                             "SPECIALIST_SCIENTIST": "Inspiration", "SPECIALIST_MERCHANT": "Guile", "SPECIALIST_ENGINEER": "Intent", "SPECIALIST_CIVIL_SERVANT": "Unity"}
SPECIALIST_TO_ICON_INFO = {"SPECIALIST_WRITER": ("EXPANSION2_BUILDING_ATLAS", "7"), "SPECIALIST_ARTIST": ("EXPANSION2_BUILDING_ATLAS", "5"), "SPECIALIST_MUSICIAN": ("EXPANSION2_BUILDING_ATLAS", "6"),
                           "SPECIALIST_SCIENTIST": ("TECH_ATLAS_1", "37"), "SPECIALIST_MERCHANT": ("EXPANSION_TECH_ATLAS_1", "2"), "SPECIALIST_ENGINEER": ("SHARED_TECH_ATLAS", "0"), "SPECIALIST_CIVIL_SERVANT": ("BW_ATLAS_2", "6")}


def create_building_classes(num_repeats):
    building_classes_node = ET.Element('BuildingClasses')
    for specialist in SPECIALISTS:
        for i in range(num_repeats):
            row = ET.Element("Row")
            add_var(row, "Type", get_str_building_buildingclass(specialist, i))
            add_var(row, "DefaultBuilding",
                    get_str_building_type(specialist, i))
            add_var(row, "Description", get_txt_tag_display_name(specialist, i))
            building_classes_node.append(row)
    return building_classes_node


def create_buildings(num_repeats):
    buildings = ET.Element("Buildings")
    for specialist in SPECIALISTS:
        for i in range(num_repeats):
            row = ET.Element("Row")
            add_var(row, "Type", get_str_building_type(specialist, i))
            add_var(row, "BuildingClass",
                    get_str_building_buildingclass(specialist, i))
            add_var(row, "Description", get_txt_tag_display_name(specialist, i))
            # add_var(row, "Civilopedia", "TXT_KEY_BUILDING_STUPA_TEXT")
            # add_var(row, "Strategy", "TXT_KEY_BUILDING_STUPA_STRATEGY")
            add_var(row, "ConquestProb", "0")
            add_var(row, "ArtDefineTag", "TEMPLE")
            add_var(row, "MinAreaSize", "-1")
            add_var(row, "PrereqTech", "TECH_AGRICULTURE")
            add_var(row, "Help", "TXT_KEY_RITUAL_SPECIALIST_HELP")
            # add_var(row, "IsDummy", "1")
            add_var(row, "GreatPeopleRateChange", str(int((i+1)/2)))
            icon_info = SPECIALIST_TO_ICON_INFO[specialist]
            add_var(row, "IconAtlas", icon_info[0])
            add_var(row, "PortraitIndex", icon_info[1])
            add_var(row, "Cost", "-1")
            add_var(row, "FaithCost", f"{int(500 * ((i + 1)**1.35))}")
            add_var(row, "SpecialistType", specialist)
            add_var(row, "SpecialistCount", "4")
            buildings.append(row)
    return buildings


def create_classes_needed(num_repeats):
    classes_needed = ET.Element("Building_ClassesNeededInCity")
    for specialist in SPECIALISTS:
        for i in range(num_repeats):
            row = ET.Element("Row")
            add_var(row, "BuildingType", get_str_building_type(specialist, i))
            if i == 0:
                add_var(row, "BuildingClassType", "BUILDINGCLASS_RITUAL_HEART")
            else:
                add_var(row, "BuildingClassType",
                        get_str_building_buildingclass(specialist, i-1))
            classes_needed.append(row)
    return classes_needed


def create_txt(num_repeats):
    txt = ET.Element("Language_en_US")
    for specialist in SPECIALISTS:
        for i in range(num_repeats):
            row = ET.Element(
                "Row", Tag=get_txt_tag_display_name(specialist, i))
            add_var(row, "Text", get_txt_str_display_name(specialist, i))
            txt.append(row)
    row = ET.Element("Row", Tag="TXT_KEY_RITUAL_SPECIALIST_HELP")
    add_var(row, "Text", "A simple ritual, cascading in power.")
    txt.append(row)
    return txt


def get_txt_tag_display_name(specialist, i):
    return f"TXT_KEY_BUILDING_{specialist}_{i}"


def get_txt_str_display_name(specialist, i):
    return f"Ritual of {SPECIALIST_TO_RITUAL_NAME[specialist]} {ORDINALS[i]} Seal"


def add_var(root, name, text):
    ele = ET.Element(name)
    ele.text = text
    root.append(ele)


def get_str_building_type(specialist, i):
    return f"BUILDING_RITUAL_{specialist}_{i}"


def get_str_building_buildingclass(specialist, i):
    return f"BUILDINGCLASS_RITUAL_{specialist}_{i}"


def create_doc(num_repeats):
    building_classes = create_building_classes(num_repeats)
    buildings = create_buildings(num_repeats)
    building_classes_needed_in_city = create_classes_needed(num_repeats)
    text = create_txt(num_repeats)
    root = ET.Element("GameData")
    root.append(building_classes)
    root.append(buildings)
    root.append(building_classes_needed_in_city)
    root.append(text)
    write_to_file(root)


def write_to_file(element, file="output.xml"):
    tree = ET.ElementTree(element)
    xmlstr = minidom.parseString(ET.tostring(element)).toprettyxml(
        indent="   ")
    with open("RitualSpecialists.xml", "w") as f:
        f.write(xmlstr)


if __name__ == "__main__":
    create_doc(10)
