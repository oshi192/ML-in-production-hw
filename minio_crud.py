from minio import Minio
from minio import S3Error

USER_NAME = "testuser"
USER_SECRET = "testuser"


def main():
    # Create a client with the MinIO server playground, its access key
    # and secret key.
    client = Minio(
        "localhost:9090",
        # access_key=USER_NAME,
        access_key="2izUNxGn7qpCj6Wc",
        # secret_key=USER_SECRET,
        secret_key="GTtgSH19TwWFlTaSr6cmWyT14RAdFBk5",
        secure=False,
    )

    # Make 'asiatrip' bucket if not exist.
    found = client.bucket_exists("asiatrip")
    if not found:
        client.make_bucket("asiatrip")
    else:
        print("Bucket 'asiatrip' already exists")

    # Upload '/home/user/Photos/asiaphotos.zip' as object name
    # 'asiaphotos-2015.zip' to bucket 'asiatrip'.
    client.fput_object(
        "asiatrip", "asiaphotos-2015.zip", "/home/user/Photos/asiaphotos.zip",
    )
    print(
        "'/home/user/Photos/asiaphotos.zip' is successfully uploaded as "
        "object 'asiaphotos-2015.zip' to bucket 'asiatrip'."
    )


def load_file():
    pass


def find_file():
    pass


def update_file():
    pass


def delete_file():
    pass


if __name__ == "__main__":
    try:
        main()
    except S3Error as exc:
        print("error occurred.", exc)
