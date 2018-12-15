-- THIS FILE IS AUTOMATICALLY UPDATED BY THE COMPANION APPLICATION.

local skills = {};

skills["UPDATED TIME"] = 0;

skills["MaxExperience"] = { value = 100, parent = "" };
skills["Experience"] = { value = 0, parent = "" };

skills["MaxHealth"] = { value = 10, parent = "" };
skills["Health"] = { value = 10, parent = "" };

skills["Agility"] = { value = 1, parent = "" };
skills["Dodge"] = { value = 0, parent = "Agility" };
skills["Light Armour"] = { value = 0, parent = "Agility" };
skills["Ranged"] = { value = 0, parent = "Agility" };
skills["Speed"] = { value = 0, parent = "Agility" };

skills["Might"] = { value = 1, parent = "" };
skills["Brawn"] = { value = 0, parent = "Might" };
skills["Heavy Armour"] = { value = 0, parent = "Might" };
skills["Melee"] = { value = 0, parent = "Might" };
skills["Shield"] = { value = 0, parent = "Might" };

skills["Presence"] = { value = 1, parent = "" };
skills["Authority"] = { value = 0, parent = "Presence" };
skills["Charm"] = { value = 0, parent = "Presence" };
skills["Deception"] = { value = 0, parent = "Presence" };
skills["Perception"] = { value = 0, parent = "Presence" };

skills["Brains"] = { value = 1, parent = "" };
skills["Engineering"] = { value = 0, parent = "Brains" };
skills["History"] = { value = 0, parent = "Brains" };
skills["Medicine"] = { value = 0, parent = "Brains" };
skills["Warcraft"] = { value = 0, parent = "Brains" };

skills["Magic"] = { value = 1, parent = "" };
skills["Arcane"] = { value = 0, parent = "Magic" };
skills["Druidic"] = { value = 0, parent = "Magic" };
skills["Fel"] = { value = 0, parent = "Magic" };
skills["Fire"] = { value = 0, parent = "Magic" };
skills["Ice"] = { value = 0, parent = "Magic" };
skills["Light"] = { value = 0, parent = "Magic" };
skills["Shadow"] = { value = 0, parent = "Magic" };

DosakisEmoteCombatAddOn["externalStore"] = skills;
