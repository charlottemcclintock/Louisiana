def process_csv(filepath):
    import unicodecsv as csv
    with open(filepath,'rb') as f:
        fc = csv.DictReader(f)
        data = list(fc)
    from agefromname import AgeFromName
    age_from_name = AgeFromName() # initialize once; reuse.
    out = []
    for row in data:
        firstname = row["candidate"].split()[0]
        if len(firstname) <= 2 or firstname.endswith('.'):
            firstname = firstname = row["candidate"].split()[1]
        firstname = firstname.lower().replace('"','')

        (sex, age, confidence) = est_sex_age(firstname,age_from_name, min_age=28)
        row['sex'] = sex
        row['age'] = age
        row['estimate_confidence'] = confidence
        out.append(row)
        print row['candidate'], sex, age, confidence
    with open(filepath+'_revised.csv','wb') as f:
        fc = csv.DictWriter(f,fieldnames=data.keys())
        fc.writeheader()
        fc.writerows(out)
    print f.name,'written'

def est_sex_age(firstname,age_from_name, min_age):
    est = age_from_name.prob_female(firstname.lower(), minimum_age=min_age) # statistically unlikely these board members are under 35.
    confidence = 0
    # next, estimate age
    if est < 0.40:
        sex = 'm'
        confidence = 1-est
    elif est > 0.60:
        sex = 'f'
        confidence = est
    else:
        sex = None
        confidence = 0
    if sex == None:
        return (None,None,0)
    age = age_from_name.argmax(firstname.lower(), sex, minimum_age=min_age)
    return (sex, age, confidence)  
