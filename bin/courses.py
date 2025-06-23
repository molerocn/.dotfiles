import os, sys

prefix = "https://class.utp.edu.pe/student/courses/"
courses = {
    "etica": "90073b57-bbb1-57c8-979e-54e11f6ff1f9/section/8de01c2e-dd0f-5412-9f22-9e837fd89e5c/learnv2",
    "calidad": "0087af42-1c10-5580-b9c1-b2a1659bbe48/section/9f2a8444-48c6-5ebc-b78a-ea25e3f0c875/learnv2",
    "aplicaciones": "8b52f37b-ea81-597b-a3af-4cc60b243a22/section/570d3d56-9618-532f-a79b-66f79f202624/learnv2",
    "software": "23d5e5a0-3c74-5963-ba28-f188d93c237f/section/d51d4b79-2706-545c-89ab-d72dacad77ad/learnv2",
    "empleabilidad": "f200b216-b756-5050-95a0-4c4ba4f397c9/section/03a2325c-c696-5def-829e-c972c898b5e0/learnv2",
    "perifericos": "60112d3c-e162-5781-9e5c-092c33edfa4d/section/e996984f-1635-5fcb-b750-ec4ac0ff9738/learnv2",
    "taller": "413b3352-57f6-51da-b6c5-91ba2732264d/section/a3377b8b-03db-5a94-a6a2-f8ae23f09af9/learnv2",
}

if __name__ == "__main__":
    browser = "firefox"
    command = str(sys.argv[1])
    if command == "list":
        for course in courses.keys():
            print(f"{course}: {courses[course]}")
    else:
        os.system(f"{browser} {prefix}{courses.get(command)}")
