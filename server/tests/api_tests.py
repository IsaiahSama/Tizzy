from requests import post

BASE_URL = "http://127.0.0.1:8000/"

sample_device_1 = {"device_id": "test_device_1", "fcm_key": "test_fcm_key_1"}
sample_device_2 = {"device_id": "test_device_2", "fcm_key": "test_fcm_key_2"}
sample_device_3 = {"device_id": "test_device_3", "fcm_key": "test_fcm_key_3"}

companion_1 = {"device_id": "test_device_1", "fcm_key": "test_fcm_key_1", "companion_id": "test_device_2"}
companion_2 = {"device_id": "test_device_2", "fcm_key": "test_fcm_key_2", "companion_id": "test_device_4"}
companion_3 = {"device_id": "test_device_3", "fcm_key": "test_fcm_key_3", "companion_id": "test_device_4"}

def test_register_device(data:dict):
    response = post(BASE_URL + "register", data=data)
    print(response.json())
    assert response.status_code == 200
    
def test_register_device_exists(data:dict):
    response = post(BASE_URL + "register", data=data)
    print(response.json())
    assert response.status_code != 200
    
def test_add_companion(data:dict):
    response = post(BASE_URL + "companion", data=data)
    print(response.json())
    assert response.status_code == 200
    
def test_add_companion_no_device(data:dict):
    response = post(BASE_URL + "companion", data=data)
    print(response.json())
    assert response.status_code == 404
    
def test_add_companion_no_companion(data:dict):
    response = post(BASE_URL + "companion", data=data)
    print(response.json())
    assert response.status_code == 404
    
def run_test(func_name:str, test_function, data:dict):
    print("Running test: " + func_name)

    try:
        test_function(data)
    except AssertionError as e:
        print('Test Failed: ' + func_name)
        print(e)
    except Exception as e:
        print(e)
        return
    
    print("-"*50)

if __name__ == "__main__":
    run_test("test_register_device", test_register_device, sample_device_1)
    run_test("test_register_device", test_register_device, sample_device_2)
    run_test("test_register_device", test_register_device_exists, sample_device_2)
    run_test("test_add_companion", test_add_companion, companion_1)
    run_test("test_add_companion_no_device", test_add_companion_no_device, companion_3)
    run_test("test_add_companion_no_companion", test_add_companion_no_companion, companion_2)