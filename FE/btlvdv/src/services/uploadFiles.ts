import axios from 'axios';

export default async function uploadFiles(Files?: any): Promise<any> {
    let listImage: string[] = [];
    try {
        if (Files && Files.fileList && Array.isArray(Files.fileList)) {
            await Promise.all(Files.fileList.map(async (file: any) => {
                const formData: FormData = new FormData();
                const data = file.originFileObj;
                formData.append('file', data);
                try {
                    const res = await axios.post("https://localhost:44381/api/UpLoad_/upload", formData, {
                        headers: {
                            "Custom-Header": "value"
                        }
                    });
                    console.log("uploadthanhcong");
                    listImage.push(res.data.filePath);
                } catch (err) {
                    console.log("UploadFile fail" + err);
                }
            }));
        } else {
            console.log("Invalid Files object or fileList is not an array.");
        }

        return listImage;
    } catch (error) {
        console.error("Error uploading files:", error);
        return null;
    }
}

export async function uploadMultipleFiles(files: File[]): Promise<string[]> {
    const uploadedUrls: string[] = [];

    try {
        // Upload each file individually using the working /upload endpoint
        await Promise.all(files.map(async (file) => {
            const formData = new FormData();
            formData.append('file', file);
            
            try {
                const response = await axios.post(
                    "https://localhost:44381/api/UpLoad_/upload",
                    formData,
                    {
                        headers: {
                            'Content-Type': 'multipart/form-data'
                        }
                    }
                );
                
                if (response.data && response.data.filePath) {
                    uploadedUrls.push(response.data.filePath);
                }
            } catch (err) {
                console.error("Error uploading file:", err);
            }
        }));

        return uploadedUrls;
    } catch (error) {
        console.error("Error in uploadMultipleFiles:", error);
        throw error;
    }
}


