import Foundation
class FMS {
    static func getDocDir() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("Doc Dir : \(paths[0])")
        return paths[0]
    }
    static func getFileList() -> [String] {
        
        var filelist = [String]()
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].path
        do{
            filelist = try FileManager.default.contentsOfDirectory(atPath : paths)
            return filelist
        } catch {
            print("Could not search for urls of files in documents directory: \(error)")
        }
        return filelist
    }
}
